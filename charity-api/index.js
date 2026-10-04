const express = require('express');
const cors = require('cors');
const db = require('./event_db');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

// API 1: 获取首页活动列表
app.get('/api/events', async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT e.event_id, e.event_name, e.description, 
                   DATE_FORMAT(e.event_date, '%Y-%m-%d') AS event_date, 
                   e.event_time,
                   e.location, e.ticket_price, e.goal_amount, e.raised_amount,
                   e.image_url, c.category_name
            FROM events e
            JOIN categories c ON e.category_id = c.category_id
            WHERE e.status = 'active'
              AND e.event_date >= CURDATE()
            ORDER BY e.event_date ASC
        `);
        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Database error' });
    }
});

// API 2: 搜索活动（按日期、地点、类别）
app.get('/api/events/search', async (req, res) => {
    try {
        const { date, location, category } = req.query;
        let sql = `
            SELECT e.event_id, e.event_name, e.description, 
                   DATE_FORMAT(e.event_date, '%Y-%m-%d') AS event_date, 
                   e.event_time,
                   e.location, e.ticket_price, e.goal_amount, e.raised_amount,
                   e.image_url, c.category_name
            FROM events e
            JOIN categories c ON e.category_id = c.category_id
            WHERE e.status = 'active'
        `;
        const params = [];

        if (date) {
            sql += ' AND e.event_date = ?';
            params.push(date);
        }
        if (location) {
            sql += ' AND e.location LIKE ?';
            params.push(`%${location}%`);
        }
        if (category) {
            sql += ' AND c.category_name = ?';
            params.push(category);
        }

        sql += ' ORDER BY e.event_date ASC';

        const [rows] = await db.query(sql, params);
        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Database error' });
    }
});
// API 3: 获取所有活动类别
app.get('/api/categories', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM categories ORDER BY category_id');
        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Database error' });
    }
});
// API 4: 获取单个活动详情
app.get('/api/events/:id', async (req, res) => {
    try {
        const eventId = req.params.id;
        const [rows] = await db.query(`
            SELECT e.event_id, e.event_name, e.description, 
                   DATE_FORMAT(e.event_date, '%Y-%m-%d') AS event_date, 
                   e.event_time, e.location, e.ticket_price, e.goal_amount, 
                   e.raised_amount, e.status, e.image_url, e.category_id, e.org_id,
                   c.category_name, o.org_name, o.mission, o.email, o.phone
            FROM events e
            JOIN categories c ON e.category_id = c.category_id
            JOIN organisations o ON e.org_id = o.org_id
            WHERE e.event_id = ?
        `, [eventId]);

        if (rows.length === 0) {
            return res.status(404).json({ error: 'Event not found' });
        }
        res.json(rows[0]);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Database error' });
    }
});
// 启动服务器
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
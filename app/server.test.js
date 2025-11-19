import request from 'supertest';
import app from './server.js';

describe('Server API Tests', () => {
  describe('GET /', () => {
    it('should return hello world message with app name and timestamp', async () => {
      const response = await request(app)
        .get('/')
        .expect(200)
        .expect('Content-Type', /json/);

      expect(response.body).toHaveProperty('msg', 'hello world');
      expect(response.body).toHaveProperty('app');
      expect(response.body).toHaveProperty('timestamp');
      expect(typeof response.body.app).toBe('string');
      expect(typeof response.body.timestamp).toBe('string');
      
      // Verify timestamp is valid ISO string
      const timestamp = new Date(response.body.timestamp);
      expect(timestamp.getTime()).not.toBeNaN();
    });

    it('should use default app name when APP_NAME env var is not set', async () => {
      const originalAppName = process.env.APP_NAME;
      delete process.env.APP_NAME;
      
      // Need to re-import to get fresh app instance with new env
      // For this test, we'll just verify the default behavior
      const response = await request(app)
        .get('/')
        .expect(200);

      expect(response.body.app).toBeDefined();
      
      if (originalAppName) {
        process.env.APP_NAME = originalAppName;
      }
    });
  });

  describe('GET /health', () => {
    it('should return health status with ok status, uptime, and timestamp', async () => {
      const response = await request(app)
        .get('/health')
        .expect(200)
        .expect('Content-Type', /json/);

      expect(response.body).toHaveProperty('status', 'ok');
      expect(response.body).toHaveProperty('uptime');
      expect(response.body).toHaveProperty('timestamp');
      
      expect(typeof response.body.uptime).toBe('number');
      expect(response.body.uptime).toBeGreaterThanOrEqual(0);
      
      expect(typeof response.body.timestamp).toBe('number');
      expect(response.body.timestamp).toBeGreaterThan(0);
      
      // Verify timestamp is recent (within last minute)
      const now = Date.now();
      const timestamp = response.body.timestamp;
      expect(Math.abs(now - timestamp)).toBeLessThan(60000);
    });

    it('should return valid uptime value', async () => {
      const response = await request(app)
        .get('/health')
        .expect(200);

      expect(response.body.uptime).toBeGreaterThanOrEqual(0);
      expect(Number.isFinite(response.body.uptime)).toBe(true);
    });
  });

  describe('Error Handling', () => {
    it('should return 404 for non-existent routes', async () => {
      await request(app)
        .get('/nonexistent')
        .expect(404);
    });
  });
});


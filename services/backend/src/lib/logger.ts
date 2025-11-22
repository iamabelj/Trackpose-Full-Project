// Winston logger configuration
import winston from 'winston';

const level = process.env.LOG_LEVEL || 'info';
const isDev = process.env.NODE_ENV === 'development';

export const logger = winston.createLogger({
  level,
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    isDev ? winston.format.prettyPrint() : winston.format.json()
  ),
  transports: [
    new winston.transports.Console({
      format: isDev
        ? winston.format.combine(winston.format.colorize(), winston.format.simple())
        : winston.format.json(),
    }),
  ],
});

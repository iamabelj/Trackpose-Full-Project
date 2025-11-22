import jwt from 'jsonwebtoken';
import type { StringValue } from 'ms';

const JWT_SECRET = process.env.JWT_SECRET || 'dev-secret-change-in-production';
const JWT_EXPIRES_IN: StringValue = (process.env.JWT_EXPIRES_IN || '7d') as StringValue;

export type JwtPayload = { [key: string]: any };

/**
 * Sign a payload into a JWT.
 * Compatible with jsonwebtoken v9+
 */
export function signToken(payload: object, expiresIn?: StringValue | number): string {
  const options: jwt.SignOptions = { 
    expiresIn: expiresIn || JWT_EXPIRES_IN
  };
  return jwt.sign(payload, JWT_SECRET, options);
}

/**
 * Verify a JWT and return decoded payload or null.
 */
export function verifyToken<T = any>(token: string): T | null {
  try {
    return jwt.verify(token, JWT_SECRET) as T;
  } catch {
    return null;
  }
}

export default { signToken, verifyToken };

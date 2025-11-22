// START FILE: services/backend/src/lib/jwt.ts
import jwt from 'jsonwebtoken';

const JWT_SECRET = process.env.JWT_SECRET || 'dev-secret';
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '1h';

export type JwtPayload = { [key: string]: any };

/**
 * Sign a payload into a JWT.
 */
export function signToken(payload: object, options?: any): string {
  const opts = { 
    expiresIn: JWT_EXPIRES_IN, 
    ...(options || {}) 
  };
  return jwt.sign(payload, JWT_SECRET, opts);
}

/**
 * Verify a JWT and return decoded payload or null.
 */
export function verifyToken<T = any>(token: string): T | null {
  try {
    const decoded = jwt.verify(token, JWT_SECRET) as T;
    return decoded;
  } catch (err) {
    return null;
  }
}

export default { signToken, verifyToken };
// END FILE

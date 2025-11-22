// START FILE: services/backend/src/lib/jwt.ts
import jwt, { SignOptions, JwtPayload as JwtPayloadType, Secret } from 'jsonwebtoken';

const JWT_SECRET = process.env.JWT_SECRET || 'dev-secret';
const JWT_EXPIRES_IN = (process.env.JWT_EXPIRES_IN || '1h') as string;

export type JwtPayload = JwtPayloadType | { [key: string]: any };

/**
 * Sign a payload into a JWT.
 * Uses jsonwebtoken types & Secret for compatibility with v9+.
 */
export function signToken(payload: object, options?: SignOptions): string {
  const opts: SignOptions = { expiresIn: JWT_EXPIRES_IN as any, ...(options || {}) };
  return jwt.sign(payload as string | object | Buffer, JWT_SECRET as Secret, opts);
}

/**
 * Verify a JWT and return decoded payload or null.
 */
export function verifyToken<T = any>(token: string): T | null {
  try {
    const decoded = jwt.verify(token, JWT_SECRET as Secret) as T;
    return decoded;
  } catch (err) {
    return null;
  }
}

export default { signToken, verifyToken };
// END FILE

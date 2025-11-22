// JWT authentication middleware
import { Request, Response, NextFunction } from 'express';
import { verifyToken, JwtPayload } from '../lib/jwt';

// Extend Express Request type
declare global {
  namespace Express {
    interface Request {
      user?: JwtPayload;
    }
  }
}

/**
 * JWT authentication middleware
 * Attaches decoded user to req.user
 */
export function authenticate(req: Request, res: Response, next: NextFunction) {
  try {
    const authHeader = req.headers.authorization;
    
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({
        success: false,
        error: 'UNAUTHORIZED',
        message: 'No authentication token provided',
      });
    }

    const token = authHeader.substring(7);
    const decoded = verifyToken(token);
    
    req.user = decoded;
    next();
  } catch (error: any) {
    return res.status(401).json({
      success: false,
      error: 'UNAUTHORIZED',
      message: error.message || 'Invalid authentication token',
    });
  }
}

/**
 * Require specific role
 */
export function requireRole(allowedRoles: string | string[]) {
  const roles = Array.isArray(allowedRoles) ? allowedRoles : [allowedRoles];
  
  return (req: Request, res: Response, next: NextFunction) => {
    if (!req.user) {
      return res.status(401).json({
        success: false,
        error: 'UNAUTHORIZED',
        message: 'Authentication required',
      });
    }

    if (!roles.includes(req.user.role)) {
      return res.status(403).json({
        success: false,
        error: 'FORBIDDEN',
        message: 'Insufficient permissions',
      });
    }

    next();
  };
}

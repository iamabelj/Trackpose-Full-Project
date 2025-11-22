// Middleware to enforce email verification before facility linking
import { Request, Response, NextFunction } from 'express';
import prisma from '../lib/db';

export async function verifyEmailEnforced(req: Request, res: Response, next: NextFunction) {
  try {
    if (!req.user) {
      return res.status(401).json({
        success: false,
        error: 'UNAUTHORIZED',
        message: 'Authentication required',
      });
    }

    const user = await prisma.user.findUnique({
      where: { id: req.user.userId },
      select: { email_verified: true },
    });

    if (!user || !user.email_verified) {
      return res.status(403).json({
        success: false,
        error: 'EMAIL_NOT_VERIFIED',
        message: 'Please verify your email before accessing this resource',
      });
    }

    next();
  } catch (error) {
    next(error);
  }
}

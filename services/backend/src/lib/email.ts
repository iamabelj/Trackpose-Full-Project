// Email service using SendGrid with nodemailer fallback
// Required env: SENDGRID_API_KEY, EMAIL_FROM or SMTP_* vars
import sgMail from '@sendgrid/mail';
import nodemailer from 'nodemailer';
import { logger } from './logger';

const SENDGRID_API_KEY = process.env.SENDGRID_API_KEY;
const EMAIL_FROM = process.env.EMAIL_FROM || 'noreply@trackpose.com';
const isDev = process.env.NODE_ENV !== 'production';

// Configure SendGrid
if (SENDGRID_API_KEY) {
  sgMail.setApiKey(SENDGRID_API_KEY);
} else if (!isDev) {
  logger.warn('SENDGRID_API_KEY not set - emails will fail in production');
}

// Nodemailer SMTP fallback
const smtpTransporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST || 'smtp.gmail.com',
  port: parseInt(process.env.SMTP_PORT || '587'),
  secure: process.env.SMTP_SECURE === 'true',
  auth: process.env.SMTP_USER ? {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASSWORD,
  } : undefined,
});

/**
 * Send email via SendGrid or SMTP fallback
 */
async function sendEmail(to: string, subject: string, html: string): Promise<void> {
  if (isDev) {
    logger.info(`[DEV] Email to ${to}: ${subject}`);
    logger.debug(`Email content: ${html}`);
    return;
  }

  try {
    if (SENDGRID_API_KEY) {
      await sgMail.send({
        to,
        from: EMAIL_FROM,
        subject,
        html,
      });
      logger.info(`Email sent via SendGrid to ${to}`);
    } else if (process.env.SMTP_USER) {
      await smtpTransporter.sendMail({
        from: EMAIL_FROM,
        to,
        subject,
        html,
      });
      logger.info(`Email sent via SMTP to ${to}`);
    } else {
      logger.warn(`Email not sent - no provider configured: ${to}`);
    }
  } catch (error: any) {
    logger.error('Email send failed:', error);
    throw new Error(`Email send failed: ${error.message}`);
  }
}

/**
 * Send email verification code
 */
export async function sendVerificationEmail(email: string, code: string): Promise<void> {
  const subject = 'Verify your TrackPose email';
  const html = `
    <h2>Welcome to TrackPose!</h2>
    <p>Your verification code is: <strong>${code}</strong></p>
    <p>This code will expire in 15 minutes.</p>
    <p>If you didn't request this, please ignore this email.</p>
  `;

  await sendEmail(email, subject, html);
}

/**
 * Send facility access code
 * Subject must be exactly: "Your TrackPose Access Code"
 */
export async function sendAccessCode(email: string, code: string, facilityName: string): Promise<void> {
  const subject = 'Your TrackPose Access Code';
  const html = `
    <h2>Your TrackPose Access Code</h2>
    <p>You have been granted access to <strong>${facilityName}</strong>.</p>
    <p>Your access code is: <strong>${code}</strong></p>
    <p>Enter this code in the TrackPose app to connect to the facility.</p>
    <p>This code will expire in 30 days.</p>
  `;

  await sendEmail(email, subject, html);
}

/**
 * Send password reset email
 */
export async function sendPasswordResetEmail(email: string, resetToken: string): Promise<void> {
  const resetUrl = `${process.env.FRONTEND_URL || 'http://localhost:3000'}/reset-password?token=${resetToken}`;
  const subject = 'Reset your TrackPose password';
  const html = `
    <h2>Password Reset Request</h2>
    <p>Click the link below to reset your password:</p>
    <p><a href="${resetUrl}">${resetUrl}</a></p>
    <p>This link will expire in 1 hour.</p>
    <p>If you didn't request this, please ignore this email.</p>
  `;

  await sendEmail(email, subject, html);
}

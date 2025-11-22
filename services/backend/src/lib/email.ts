// START FILE: services/backend/src/lib/email.ts
import nodemailer from 'nodemailer';

const SMTP_HOST = process.env.EMAIL_SMTP_HOST;
const SMTP_PORT = Number(process.env.EMAIL_SMTP_PORT || 587);
const SMTP_SECURE = process.env.EMAIL_SMTP_SECURE === 'true';
const SMTP_USER = process.env.EMAIL_SMTP_USER;
const SMTP_PASS = process.env.EMAIL_SMTP_PASS;
const EMAIL_FROM = process.env.EMAIL_FROM || 'no-reply@trackpose.example';

/**
 * Build transporter lazily at runtime. If SMTP not configured, functions will throw.
 */
function createTransporter() {
  if (!SMTP_HOST || !SMTP_USER || !SMTP_PASS) {
    // In non-production environments, do not create transporter.
    return null;
  }
  return nodemailer.createTransport({
    host: SMTP_HOST,
    port: SMTP_PORT,
    secure: SMTP_SECURE,
    auth: {
      user: SMTP_USER,
      pass: SMTP_PASS,
    },
  });
}

export async function sendEmail(to: string, subject: string, html: string) {
  const transporter = createTransporter();
  if (!transporter) {
    // If mail is not configured, log and avoid throwing in production builds.
    // TODO: consider failing hard in production if email is required.
    console.warn('Email not configured; skipping sendEmail to', to);
    return;
  }
  await transporter.sendMail({
    from: EMAIL_FROM,
    to,
    subject,
    html,
  });
}
export default { sendEmail };
// END FILE

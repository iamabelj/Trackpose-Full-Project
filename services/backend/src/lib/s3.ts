// S3 storage operations using AWS SDK v3
// Supports both AWS S3 and Render Object Storage via S3_ENDPOINT
// Required env vars: S3_BUCKET, S3_REGION, S3_ACCESS_KEY_ID, S3_SECRET_ACCESS_KEY, S3_ENDPOINT (optional)
import {
  S3Client,
  PutObjectCommand,
  GetObjectCommand,
  DeleteObjectCommand,
} from '@aws-sdk/client-s3';
import { getSignedUrl as awsGetSignedUrl } from '@aws-sdk/s3-request-presigner';
import { createReadStream } from 'fs';
import { logger } from './logger';

const s3Config: any = {
  region: process.env.S3_REGION || 'us-east-1',
  credentials: {
    accessKeyId: process.env.S3_ACCESS_KEY_ID || '',
    secretAccessKey: process.env.S3_SECRET_ACCESS_KEY || '',
  },
};

// Support Render Object Storage or S3-compatible endpoints
if (process.env.S3_ENDPOINT) {
  s3Config.endpoint = process.env.S3_ENDPOINT;
  s3Config.forcePathStyle = true;
}

const s3Client = new S3Client(s3Config);
const bucket = process.env.S3_BUCKET || '';

if (!bucket && process.env.NODE_ENV === 'production') {
  logger.error('S3_BUCKET not configured');
}

/**
 * Upload buffer to S3
 */
export async function uploadBuffer(
  key: string,
  buffer: Buffer,
  contentType?: string
): Promise<string> {
  try {
    const command = new PutObjectCommand({
      Bucket: bucket,
      Key: key,
      Body: buffer,
      ContentType: contentType || 'application/octet-stream',
    });

    await s3Client.send(command);
    
    const url = process.env.S3_ENDPOINT
      ? `${process.env.S3_ENDPOINT}/${bucket}/${key}`
      : `https://${bucket}.s3.${process.env.S3_REGION}.amazonaws.com/${key}`;

    logger.info(`Uploaded to S3: ${key}`);
    return url;
  } catch (error: any) {
    logger.error('S3 upload failed:', error);
    throw new Error(`S3 upload failed: ${error.message}`);
  }
}

/**
 * Upload file from filesystem to S3
 */
export async function uploadFile(
  key: string,
  filePath: string,
  contentType?: string
): Promise<string> {
  try {
    const fileStream = createReadStream(filePath);
    const command = new PutObjectCommand({
      Bucket: bucket,
      Key: key,
      Body: fileStream as any,
      ContentType: contentType,
    });

    await s3Client.send(command);

    const url = process.env.S3_ENDPOINT
      ? `${process.env.S3_ENDPOINT}/${bucket}/${key}`
      : `https://${bucket}.s3.${process.env.S3_REGION}.amazonaws.com/${key}`;

    logger.info(`Uploaded file to S3: ${key}`);
    return url;
  } catch (error: any) {
    logger.error('S3 file upload failed:', error);
    throw new Error(`S3 file upload failed: ${error.message}`);
  }
}

/**
 * Get signed URL for temporary access
 */
export async function getSignedUrl(key: string, expiresIn: number = 3600): Promise<string> {
  try {
    const command = new GetObjectCommand({
      Bucket: bucket,
      Key: key,
    });

    const url = await awsGetSignedUrl(s3Client, command, { expiresIn });
    return url;
  } catch (error: any) {
    logger.error('Get signed URL failed:', error);
    throw new Error(`Get signed URL failed: ${error.message}`);
  }
}

/**
 * Delete object from S3
 */
export async function deleteObject(key: string): Promise<void> {
  try {
    const command = new DeleteObjectCommand({
      Bucket: bucket,
      Key: key,
    });

    await s3Client.send(command);
    logger.info(`Deleted from S3: ${key}`);
  } catch (error: any) {
    logger.error('S3 delete failed:', error);
    throw new Error(`S3 delete failed: ${error.message}`);
  }
}

/**
 * Extract S3 key from URL
 */
export function extractS3Key(url: string): string | null {
  try {
    const urlObj = new URL(url);
    // Handle both path-style and virtual-hosted-style URLs
    if (urlObj.pathname.startsWith(`/${bucket}/`)) {
      return urlObj.pathname.substring(`/${bucket}/`.length);
    }
    return urlObj.pathname.substring(1);
  } catch {
    return null;
  }
}

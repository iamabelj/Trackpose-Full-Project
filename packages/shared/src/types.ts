/**
 * Generated canonical types for TrackPose - source of truth.
 * 
 * This file defines all TypeScript interfaces matching the DATA MODEL.
 * These types are used across backend, frontend, and exported to mobile (Dart).
 * 
 * DO NOT manually edit these types without updating the Prisma schema.
 */

// ============================================================================
// ENUMS
// ============================================================================

export enum UserRole {
  PARENT = 'PARENT',
  GUARDIAN = 'GUARDIAN',
  FACILITY_STAFF = 'FACILITY_STAFF',
  FACILITY_ADMIN = 'FACILITY_ADMIN',
  SYSTEM_ADMIN = 'SYSTEM_ADMIN',
}

export enum FacilityType {
  DAYCARE = 'DAYCARE',
  SCHOOL = 'SCHOOL',
  SENIOR_CARE = 'SENIOR_CARE',
  HOME = 'HOME',
  OTHER = 'OTHER',
}

export enum SubscriptionPlan {
  TRIAL = 'TRIAL',
  STANDARD = 'STANDARD',
  PREMIUM = 'PREMIUM',
  ENTERPRISE = 'ENTERPRISE',
}

export enum SubscriptionStatus {
  ACTIVE = 'ACTIVE',
  TRIAL = 'TRIAL',
  CANCELED = 'CANCELED',
  PAST_DUE = 'PAST_DUE',
  EXPIRED = 'EXPIRED',
}

export enum SessionSource {
  UPLOAD = 'UPLOAD',
  LIVE = 'LIVE',
  SCHEDULED = 'SCHEDULED',
}

export enum SessionStatus {
  PENDING = 'PENDING',
  PROCESSING = 'PROCESSING',
  COMPLETED = 'COMPLETED',
  FAILED = 'FAILED',
}

export enum EventType {
  EMOTION_CHANGE = 'EMOTION_CHANGE',
  ACTIVITY_CHANGE = 'ACTIVITY_CHANGE',
  ALERT = 'ALERT',
  MILESTONE = 'MILESTONE',
  INCIDENT = 'INCIDENT',
}

export enum EventSeverity {
  INFO = 'INFO',
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  CRITICAL = 'CRITICAL',
}

export enum ReportType {
  DAILY = 'DAILY',
  WEEKLY = 'WEEKLY',
  MONTHLY = 'MONTHLY',
  CUSTOM = 'CUSTOM',
  AI_INSIGHTS = 'AI_INSIGHTS',
}

export enum ReportFormat {
  PDF = 'PDF',
  CSV = 'CSV',
  JSON = 'JSON',
}

// ============================================================================
// USER
// ============================================================================

export interface User {
  id: string;
  email: string;
  password_hash: string;
  full_name: string;
  phone_number?: string;
  role: UserRole;
  email_verified: boolean;
  created_at: Date;
  updated_at: Date;
  last_login_at?: Date;
  
  // Relations
  facilities?: Facility[];
  profiles?: Profile[];
  subscriptions?: Subscription[];
  access_codes?: AccessCode[];
}

export interface UserCreateInput {
  email: string;
  password: string;
  full_name: string;
  phone_number?: string;
  role: UserRole;
}

export interface UserUpdateInput {
  full_name?: string;
  phone_number?: string;
  email?: string;
}

export interface UserResponse {
  id: string;
  email: string;
  full_name: string;
  phone_number?: string;
  role: UserRole;
  email_verified: boolean;
  created_at: Date;
  updated_at: Date;
  last_login_at?: Date;
}

// ============================================================================
// FACILITY
// ============================================================================

export interface Facility {
  id: string;
  name: string;
  type: FacilityType;
  address?: string;
  city?: string;
  state?: string;
  zip_code?: string;
  country?: string;
  phone_number?: string;
  email?: string;
  license_number?: string;
  created_at: Date;
  updated_at: Date;
  
  owner_id: string;
  
  // Relations
  owner?: User;
  profiles?: Profile[];
  sessions?: Session[];
  access_codes?: AccessCode[];
}

export interface FacilityCreateInput {
  name: string;
  type: FacilityType;
  address?: string;
  city?: string;
  state?: string;
  zip_code?: string;
  country?: string;
  phone_number?: string;
  email?: string;
  license_number?: string;
}

export interface FacilityUpdateInput {
  name?: string;
  type?: FacilityType;
  address?: string;
  city?: string;
  state?: string;
  zip_code?: string;
  country?: string;
  phone_number?: string;
  email?: string;
  license_number?: string;
}

// ============================================================================
// PROFILE (Child/Elder/Individual being monitored)
// ============================================================================

export interface Profile {
  id: string;
  first_name: string;
  last_name: string;
  date_of_birth?: Date;
  gender?: string;
  photo_url?: string;
  notes?: string;
  created_at: Date;
  updated_at: Date;
  
  guardian_id: string;
  facility_id?: string;
  
  // Relations
  guardian?: User;
  facility?: Facility;
  sessions?: Session[];
  events?: Event[];
}

export interface ProfileCreateInput {
  first_name: string;
  last_name: string;
  date_of_birth?: Date;
  gender?: string;
  photo_url?: string;
  notes?: string;
  facility_id?: string;
}

export interface ProfileUpdateInput {
  first_name?: string;
  last_name?: string;
  date_of_birth?: Date;
  gender?: string;
  photo_url?: string;
  notes?: string;
}

// ============================================================================
// SESSION (Monitoring session - video upload or live stream)
// ============================================================================

export interface Session {
  id: string;
  title?: string;
  source: SessionSource;
  status: SessionStatus;
  video_url?: string;
  thumbnail_url?: string;
  duration_seconds?: number;
  file_size_bytes?: number;
  started_at: Date;
  ended_at?: Date;
  processed_at?: Date;
  created_at: Date;
  updated_at: Date;
  
  profile_id: string;
  facility_id?: string;
  
  // AI-generated fields (populated after processing)
  emotion_summary?: EmotionSummary;
  activity_summary?: ActivitySummary;
  wellbeing_score?: number;
  
  // Relations
  profile?: Profile;
  facility?: Facility;
  events?: Event[];
  reports?: Report[];
}

export interface SessionCreateInput {
  title?: string;
  source: SessionSource;
  profile_id: string;
  facility_id?: string;
  video_url?: string;
  thumbnail_url?: string;
  started_at?: Date;
}

export interface SessionUpdateInput {
  title?: string;
  status?: SessionStatus;
  thumbnail_url?: string;
  duration_seconds?: number;
  file_size_bytes?: number;
  ended_at?: Date;
  processed_at?: Date;
  emotion_summary?: EmotionSummary;
  activity_summary?: ActivitySummary;
  wellbeing_score?: number;
}

// ============================================================================
// EVENT (Notable occurrences detected during monitoring)
// ============================================================================

export interface Event {
  id: string;
  type: EventType;
  severity: EventSeverity;
  title: string;
  description?: string;
  timestamp: Date;
  duration_seconds?: number;
  metadata?: any; // JSON field
  acknowledged: boolean;
  acknowledged_at?: Date;
  acknowledged_by?: string;
  created_at: Date;
  
  session_id: string;
  profile_id: string;
  
  // Relations
  session?: Session;
  profile?: Profile;
}

export interface EventCreateInput {
  type: EventType;
  severity: EventSeverity;
  title: string;
  description?: string;
  timestamp: Date;
  duration_seconds?: number;
  metadata?: any;
  session_id: string;
  profile_id: string;
}

// ============================================================================
// REPORT (Generated reports from sessions)
// ============================================================================

export interface Report {
  id: string;
  type: ReportType;
  format: ReportFormat;
  title: string;
  description?: string;
  report_url?: string;
  generated_at: Date;
  start_date: Date;
  end_date: Date;
  metadata?: any; // JSON field
  created_at: Date;
  
  user_id: string;
  session_id?: string;
  
  // Relations
  user?: User;
  session?: Session;
}

export interface ReportCreateInput {
  type: ReportType;
  format: ReportFormat;
  title: string;
  description?: string;
  start_date: Date;
  end_date: Date;
  session_id?: string;
}

// ============================================================================
// SUBSCRIPTION (User payment/plan subscription)
// ============================================================================

export interface Subscription {
  id: string;
  plan: SubscriptionPlan;
  status: SubscriptionStatus;
  stripe_subscription_id?: string;
  stripe_customer_id?: string;
  current_period_start?: Date;
  current_period_end?: Date;
  trial_ends_at?: Date;
  canceled_at?: Date;
  created_at: Date;
  updated_at: Date;
  
  user_id: string;
  
  // Relations
  user?: User;
}

export interface SubscriptionCreateInput {
  plan: SubscriptionPlan;
  status: SubscriptionStatus;
  stripe_subscription_id?: string;
  stripe_customer_id?: string;
  current_period_start?: Date;
  current_period_end?: Date;
  trial_ends_at?: Date;
}

export interface SubscriptionUpdateInput {
  plan?: SubscriptionPlan;
  status?: SubscriptionStatus;
  current_period_start?: Date;
  current_period_end?: Date;
  canceled_at?: Date;
}

// ============================================================================
// ACCESS CODE (Facility access codes sent via email after payment)
// ============================================================================

export interface AccessCode {
  id: string;
  code: string;
  expires_at: Date;
  used_at?: Date;
  created_at: Date;
  
  user_id: string;
  facility_id: string;
  
  // Relations
  user?: User;
  facility?: Facility;
}

export interface AccessCodeCreateInput {
  code: string;
  expires_at: Date;
  user_id: string;
  facility_id: string;
}

// ============================================================================
// EMAIL VERIFICATION
// ============================================================================

export interface EmailVerification {
  id: string;
  user_id: string;
  code: string;
  expires_at: Date;
  verified_at?: Date;
  attempts: number;
  created_at: Date;
  
  // Relations
  user?: User;
}

export interface EmailVerificationCreateInput {
  user_id: string;
  code: string;
  expires_at: Date;
}

// ============================================================================
// AI-DRIVEN INSIGHTS TYPES
// ============================================================================

export interface EmotionSummary {
  dominant: string;
  distribution: {
    [emotion: string]: number; // percentage
  };
  examples: EmotionExample[];
}

export interface EmotionExample {
  timestamp: number; // seconds from start
  label: string;
  confidence: number;
}

export interface ActivitySummary {
  active_minutes: number;
  sedentary_minutes: number;
  events: ActivityEvent[];
}

export interface ActivityEvent {
  type: string;
  timestamp: number;
  duration_seconds: number;
  description?: string;
}

export interface WellbeingInsights {
  wellbeing_score: number; // 0-100
  emotion_summary: EmotionSummary;
  activity_summary: ActivitySummary;
  social_interactions?: SocialInteraction[];
  behavioral_patterns?: BehavioralPattern[];
  health_indicators?: HealthIndicator[];
  recommendations?: string[];
}

export interface SocialInteraction {
  timestamp: number;
  type: string; // "peer_interaction", "adult_interaction", "group_activity"
  participants?: number;
  duration_seconds: number;
  quality_score?: number; // 0-100
}

export interface BehavioralPattern {
  pattern: string;
  frequency: number;
  confidence: number;
  timestamps: number[];
}

export interface HealthIndicator {
  indicator: string;
  value: number;
  unit: string;
  status: 'normal' | 'attention' | 'concern';
  note?: string;
}

// ============================================================================
// API RESPONSE TYPES
// ============================================================================

export interface ApiResponse<T = any> {
  success: boolean;
  data?: T;
  error?: string;
  message?: string;
}

export interface PaginatedResponse<T> {
  success: boolean;
  data: T[];
  pagination: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
  };
}

export interface AuthResponse {
  success: boolean;
  data: {
    user: UserResponse;
    token: string;
    refreshToken?: string;
  };
}

export interface TrialLimitError {
  error: 'TRIAL_LIMIT_REACHED';
  message: string;
  limit: number;
  current: number;
  upgrade_url?: string;
}

// ============================================================================
// JWT PAYLOAD
// ============================================================================

export interface JwtPayload {
  userId: string;
  email: string;
  role: UserRole;
  iat?: number;
  exp?: number;
}

# smart-healthcare-db

**Project:** Healthcare records system with ICD-10 coding, audit logging, and AI readiness.

## Features
-  7 tables (patients, doctors, prescriptions, etc.)
-  ICD-10 diagnosis codes (AI/ML ready)
-  Audit logging triggers (security)
-  Temporal tracking (time-series analysis)
-  Patient history views
-  Analytics queries

## Quick Setup (MySQL)
```sql
-- 1. Create database
CREATE DATABASE healthcare_simple;
USE healthcare_simple;

-- 2. Run SQL files below
Files:
database-setup.sql - Create tables
sample-data.sql - Insert data
test-queries.sql - Demo queries

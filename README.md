
# Smart Healthcare Database System

**DBMS Project** - Healthcare records system with  **ICD-10 coding**, **audit logging**, **RBAC security**, and **AI readiness**.

 - Complete healthcare management with

##  Features Demonstrated
- 7-table relational schema (3NF normalized)
- ICD-10 diagnosis standardization (AI/ML ready)
- Audit logging via database triggers (security)
- Role-Based Access Control (RBAC)
- Patient history view (5-table JOIN)
- Temporal tracking (time-series analysis)
- Test cases & analytics queries

##  1-Click Setup (MySQL)
```sql
-- Run files in this EXACT order:
1. healthcare_db.sql      # Tables + sample data  
2. audit_trigger.sql      # Security triggers
3. patient_history_view.sql # Complex views
4. security_roles.sql     # RBAC users
5. test_queries.sql       # Demo everything works

 Live Demo Queries
Patient Complete History (5-table JOIN):

sql
SELECT * FROM patient_complete_history WHERE patient_id = 1;
Audit Log (Security Demo):

sql
SELECT * FROM audit_log ORDER BY action_time DESC LIMIT 5;
Disease Analytics (AI-Ready):

sql
SELECT icd.description, COUNT(*) cases 
FROM medical_records mr JOIN icd_codes icd 
ON mr.diagnosis_code = icd.code 
GROUP BY icd.description;
```
###Security Implementation
Automatic Audit Logging:

INSERT prescription → audit_log records INSERT
UPDATE prescription → audit_log records UPDATE
DELETE prescription → audit_log records DELETE

RBAC Roles:

doctor_user → Read-only + INSERT medical_records/prescriptions
admin_user  → Full access
###AI/ML Readiness
Feature	ML Use Case
ICD-10 codes	Disease classification
Timestamps	Time-series prediction
Symptoms text	NLP symptom extraction
Lab results	Predictive modeling
###Project Stats
Tables: 7 | Records: 30+ | Triggers: 3 | Views: 1 | Tests: 20+
Grade: A | University DBMS Course 2026
##Run Order
	File	             Purpose
1	healthcare_db.sql	Core schema + sample data
2	audit_trigger.sql	Security logging
3	patient_history_view.sql	Patient timeline view
4	security_roles.sql	Doctor/Admin users
5	test_queries.sql	Validation + demos

Built by [Khadeejah Yasin]
Database Systems | Healthcare IT | AI Data Engineering

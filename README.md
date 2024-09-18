+-----------+    +--------------+    +---------------+    +---------+    +----------------+
| Patients  |    | Appointments |    |   Doctors     |    | Billing |    | MedicalRecords  |
+-----------+    +--------------+    +---------------+    +---------+    +----------------+
|patient_id |<---|appointment_id|--->| doctor_id     |    |billing_id|    | record_id       |
|first_name |    |patient_id    |    | first_name    |    |appointment_id| appointment_id   |
|last_name  |    |doctor_id     |    | last_name     |    |total_amount | diagnosis        |
|age        |    |appointment_date|  | specialty     |    |payment_status| treatment        |
|contact    |    |reason        |    +---------------+    +-----------+  +----------------+
+-----------+    |status        |  
                 +--------------+

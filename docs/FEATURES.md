# Features

## User Roles
The application has three user roles:
- **asatidzPiketMaskan**: Petugas piket asrama (dormitory duty officer)
- **resepsionisKlinik**: Klinik resepsionis (clinic receptionist)
- **dokter**: Dokter (doctor)

## Authentication
Users can log in with their email and a one-time password (OTP). The app uses Supabase for authentication.

## Dashboard
The dashboard displays an overview of the students' health, including statistics and charts. The dashboard shows the following information:
- Total illnesses this week
- Comparison percentage with last week
- Most common case
- Number of most common cases
- Number of people who need to rest
- New cases today
- Cases per day
- Cases per level
- Cases per dorm
- Pie chart of types of illnesses
- Referrals today
- Sick today

## Health Input
Users can input health data for students. The health input form has 5 steps:
1. Search for a student.
2. Select a student.
3. Enter the symptoms.
4. Enter when the illness started.
5. Check if the student needs to go to the clinic.

The health input data is stored in the `pendataan_kesehatan` table and includes the following information:
- The ID of the health input.
- The timestamp of the health input.
- The ID of the student.
- A list of symptoms.
- The start time of the illness.
- Status periksa (sudah/belum/di luar)

## Monitoring
Users can monitor the health of students. The monitoring page has three tabs:
- **Periksa:** Displays a list of students who need to be examined.
- **Arahan:** Displays a list of students with instructions from the clinic (masuk_sekolah/istirahat_asrama).
- **Rujukan RS:** Displays a list of students who have been referred to a hospital and need transportation.

## Medical History
Users can view the medical history of students. The medical history page has three sections:
- **Pendataan & Pemeriksaan:** Data Collection & Examination
- **Rujukan & Pengantaran:** Referral & Transportation
- **Identitas & Rekam Medis:** Identity & Medical Record

## Profile
Users can view and edit their profile. This feature is currently a placeholder.

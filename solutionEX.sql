-- EXERCICE 1 :  Insérer un nouveau patient
INSERT INTO
    `patients` (
        `first_name`,
        `last_name`,
        `gender`,
        `date_of_birth`,
        `phone_number`
    )
VALUES (
        'Alex',
        'Johnson',
        'Male',
        '1990-07-15',
        '1234567890'
    )

-- EXERCICE 2 : Selectioner le nom et location de tous les departments
SELECT department_name, location FROM departments

-- EXERCICE 3 : selectioner tous les patients order by date croissant
select * from patients ORDER by date_of_birth ASC

-- EXERCICE 4 : Filtrer les patients uniques par sexe (DISTINCT)
SELECT DISTINCT gender FROM patients

-- EXERCICE 5 : LIMIT Clause
SELECT first_name FROM doctors LIMIT 3;

-- EXERCICE 6 : Patients nés après 2000 Récupérez les informations des patients nés après l'année 2000.
SELECT * FROM patients WHERE year(date_of_birth) > 2000

-- EXERCICE 7 : Médecins dans des départements spécifiques Récupérez les médecins des départements "Cardiology" et "Neurology".
SELECT *
FROM departments
WHERE
    department_name IN ('Cardiology', 'Neurology')

-- EXERCICE 7 :  Vérifier des plages de dates Listez les admissions entre le 1er décembre et le 7 décembre 2024.
SELECT *
FROM `admissions`
WHERE
    admission_date BETWEEN '2024-01-01' AND '2024-01-07'

-- EXERCICE 8 :  Nommer les catégories d'âge des patients Ajoutez une colonne catégorisant les patients en "Enfant", "Adulte", ou "Senior" selon leur âge
SELECT
    *,
    CASE
        WHEN TIMESTAMPDIFF(
            YEAR,
            date_of_birth,
            CURDATE()
        ) < 18 THEN 'you are a baby'
        WHEN TIMESTAMPDIFF(
            YEAR,
            date_of_birth,
            CURDATE()
        ) BETWEEN 18 AND 64  THEN 'you are a dad'
        ELSE 'you are a grandfather'
    END as newage
FROM patients;

-- EXERCICE 9 : Nombre total de rendez-vous Comptez le nombre total de rendez-vous enregistrés.
select count(*) as NomberRendezVous FROM appointments

-- EXERCICE 10 : Comptez le nombre de médecins dans chaque département
select department_id, COUNT(department_id) AS number
from doctors
GROUP BY
    department_id

-- EXERCICE 11 : Calculez l'âge moyen des patients.
SELECT AVG(
        timestampdiff(
            year, date_of_birth, curdate()
        )
    ) AS agemoyen
from patients

-- EXERCICE 12 :Dernier rendez-vous Trouvez la date et l'heure du dernier rendez-vous enregistré
SELECT MAX(appointment_date) as maxRendezVous FROM appointments

-- EXERCICE 13 : Total des admissions par chambre Calculez le total des admissions pour chaque chambre
SELECT room_id, SUM(1) AS total_admissions
FROM admissions
GROUP BY
    room_id

-- EXERCICE 14 : tous les patients dont le champ email est vide
SELECT * FROM patients WHERE email IS NULL

-- EXERCICE 15 : les rendez-vous avec les noms des médecins et des patients
select
    a.appointment_id AS rendez_vous,
    d.first_name AS DOCTOR,
    p.first_name AS patient
from
    appointments a
    JOIN doctors d ON a.doctor_id = d.doctor_id
    JOIN patients p ON a.patient_id = p.patient_id


-- EXERCICE 16 : Supprimez tous les rendez-vous programmés avant 2024.
DELETE from appointments where year(appointment_date) < '2024'

-- EXERCICE 17 :Changez le nom du département "Oncology" en "Cancer Treatment".
UPDATE departments set department_name= 'Cancer Treatment' WHERE department_name='Oncology'

-- EXERCICE 18 : Listez les genres ayant au moins deux patients.
SELECT gender , COUNT(patient_id) FROM patients GROUP BY gender

-- EXERCICE 19 : Listez les genres ayant au moins deux patients.
SELECT gender , COUNT(patient_id) AS patient_count FROM patients  GROUP BY gender HAVING COUNT(patient_id)<2

-- EXERCICE 20 :une vue listant toutes les admissions en cours.
CREATE VIEW admissions_encours AS SELECT * from admissions WHERE discharge_date IS null
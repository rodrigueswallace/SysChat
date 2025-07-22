# SysChat - Database Structure

This project represents the physical and logical model of the database used in the SysChat system, including a data dictionary, DDL/DCL scripts, constraints, and relational models.

---

## 📁 Folder Structure


```

.github/
│
├── workflows/
│   └── backup.yml               #  Responsible for backing up the database on every merge to main

database/
│
├── data_dictionary/             #  Data dictionary (.xlsx)
├── instance_table/img/          # Table instance images (e.g., users.png)
├── logical_model/img/           # Logical model in image format
├── permissions_table/           #  Dictionary of access permissions
└── physical_model/
    ├── dcl/                     # Access control scripts
    │   ├── anonymous_user/
    │   │   └── grants.sql              # Anonymous user permissions
    │   ├── login_user/
    │   │   └── grants.sql              #  Logged-in user permissions
    │   ├── sys.anonymous_user/
    │   │   └── encapsulations.sql
    │   ├── sys_user/
    │   │   ├── encapsulations/
    │   │   │   ├── chat/encapsulations.sql
    │   │   │   ├── login_log/encapsulations.sql
    │   │   │   ├── msg/encapsulations.sql
    │   │   │   └── users/encapsulations.sql
    │   │   └── grants.sql              # System user permissions
    │   └── roles.sql                   # Role definitions in the database
    │
    ├── ddl/
    │   ├── check_constraints.sql       # Separated CHECK constraints by table
    │   └── ddl.sql                     # Schema and main table creation
    │
    ├── row-permissions/                # Row-level security permission rules
    └── metrics/                        # (Reserved for usage statistics and analysis)


```


---

## 🧱 Database Components

### 🔹 Main schema: `syschat`

Includes the following tables:

- `users` - User information (name, email, password, etc.)
- `chats` - Chat records created by users
- `messages` - Stores messages within each chat
- `login_logs` - Logs user login activity

---

## ⚙️ Important Scripts

### 🔸 `ddl.sql`
Creates the `syschat` schema and main tables.

### 🔸 `check_constraints.sql`
Contains separated `CHECK CONSTRAINTS` to maintain data integrity (e.g., non-empty name, password with minimum characters, etc.).

### 🔸 `encapsulations.sql`
Logical encapsulations for data manipulation (CRUD controlled by user/role).

### 🔸 `grants.sql`
Controls permissions by user type:
- `anonymous_user` → minimal access
- `login_user` → restricted access to own data

---

## 🔒 Security

The structure uses role-based separation in the database and encapsulation via procedures (`encapsulations.sql`) to ensure:
- Read/write restrictions
- Secure views
- Access governance

---

## 📸 Models

- Files under `instance_table/img/` and `logical_model/img/` provide visual diagrams of table instances and relationships.

---

## 📋 Requirements

- PostgreSQL 14 or higher

---

## 👨‍💻 Author

Wallace Alves Rodrigues

---

# 🗨️ SysChat - Estrutura do Banco de Dados

Este projeto representa o modelo físico e lógico do banco de dados utilizado no sistema **SysChat**, contendo dicionário de dados, scripts DDL/DCL, constraints e modelos relacionais.

---

## 📁 Estrutura de Pastas


```

.github/
│
├── workflows/
│   └── backup.yml               # Responsável por fazer o backup do banco toda vez que for feito merge na main

database/
│
├── data_dictionary/             # Dicionário de dados (.xlsx)
├── instance_table/img/          # Imagens das instâncias das tabelas (ex: users.png)
├── logical_model/img/           # Modelo lógico em imagem
├── permissions_table/           # Dicionário com permissões de acesso
└── physical_model/
    ├── dcl/                     # Scripts de controle de acesso
    │   ├── anonymous_user/
    │   │   └── grants.sql              # Permissões do usuário anônimo
    │   ├── login_user/
    │   │   └── grants.sql              # Permissões do usuário logado
    │   ├── sys.anonymous_user/
    │   │   └── encapsulations.sql
    │   ├── sys_user/
    │   │   ├── encapsulations/
    │   │   │   ├── chat/encapsulations.sql
    │   │   │   ├── login_log/encapsulations.sql
    │   │   │   ├── msg/encapsulations.sql
    │   │   │   └── users/encapsulations.sql
    │   │   └── grants.sql              # Permissões do usuário do sistema
    │   └── roles.sql                   # Definição de roles no banco
    │
    ├── ddl/
    │   ├── check_constraints.sql       # Constraints CHECK separadas por tabela
    │   └── ddl.sql                     # Criação do schema e tabelas principais
    │
    └── metrics/                        # (Reservado para estatísticas e análises de uso)


```


---

## 🧱 Componentes do Banco

### 🔹 Schema principal: `syschat`

Contém as seguintes tabelas:

- `users` - Informações de usuários (nome, email, senha, etc.)
- `chats` - Tabela de chats criados por usuários
- `messages` - Armazena mensagens em cada chat
- `login_logs` - Registra logins de usuários

---

## ⚙️ Scripts Importantes

### 🔸 `ddl.sql`
Criação do schema `syschat` e das tabelas principais.

### 🔸 `check_constraints.sql`
Contém os `CHECK CONSTRAINTS` separados para manter integridade dos dados (ex: nome não vazio, senha com mínimo de caracteres, etc.).

### 🔸 `encapsulations.sql`
Encapsulamentos lógicos para manipulação dos dados (CRUD controlado por usuário/role).

### 🔸 `grants.sql`
Controla permissões por tipo de usuário:
- `anonymous_user` → acesso mínimo
- `login_user` → acesso restrito a dados próprios
- `sys_user` → acesso completo via procedures

---

## 🔒 Segurança

A estrutura usa separação por *roles* no banco de dados e encapsulamento por procedimentos (`encapsulations.sql`) para garantir:
- Restrições de leitura/escrita
- Visões seguras
- Governança de acesso

---

## 📸 Modelos

- Os arquivos em `instance_table/img/` e `logical_model/img/` fornecem diagramas visuais de instâncias e relações das tabelas.

---

## 📋 Requisitos

- PostgreSQL 14 ou superior

---

## 👨‍💻 Autor

Wallace Alves Rodrigues 

---


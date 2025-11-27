# Academic ERP System

A comprehensive Academic ERP (Enterprise Resource Planning) system for managing students, faculty, courses, and placements.

## Project Structure

```
ESD Miniproject/
├── academic-erp-backend/     # Spring Boot backend application
│   ├── src/                  # Java source code
│   ├── pom.xml              # Maven configuration
│   └── ...
├── academic-erp-frontend/    # React frontend application
│   ├── src/                  # React components and pages
│   ├── package.json         # NPM configuration
│   └── ...
├── database/                 # Database scripts and schemas
├── product-data/            # Sample data and resources
└── README.md                # This file
```

## Getting Started

### Backend (Spring Boot)
```bash
cd academic-erp-backend
./mvnw spring-boot:run
```

### Frontend (React)
```bash
cd academic-erp-frontend
npm install
npm run dev
```

## Technologies Used

### Backend
- Java Spring Boot
- Maven
- JPA/Hibernate

### Frontend
- React
- Vite
- Bootstrap
- Axios

## Features
- Student Management
- Faculty Administration
- Course Management
- Placement Management
- Authentication & Authorization

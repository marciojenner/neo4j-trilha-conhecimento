// =====================================================================
// PROJETO: Knowledge Graph & Learning Path Engine (Neo4j)
// SCRIPT 01: Criação de Constraints e Índices de Unicidade (Expandido)
// =====================================================================

// 1. Constraint para Estudantes
CREATE CONSTRAINT student_id_unique IF NOT EXISTS
FOR (s:Student) REQUIRE s.id IS UNIQUE;

// 2. Constraint para Cursos
CREATE CONSTRAINT course_id_unique IF NOT EXISTS
FOR (c:Course) REQUIRE c.id IS UNIQUE;

// 3. Constraint para Módulos
CREATE CONSTRAINT module_id_unique IF NOT EXISTS
FOR (m:Module) REQUIRE m.id IS UNIQUE;

// 4. Constraint para Aulas
CREATE CONSTRAINT lesson_id_unique IF NOT EXISTS
FOR (l:Lesson) REQUIRE l.id IS UNIQUE;

// 5. Constraint para Habilidades (Skills)
CREATE CONSTRAINT skill_id_unique IF NOT EXISTS
FOR (sk:Skill) REQUIRE sk.id IS UNIQUE;

// 6. Constraint para Instrutores (Novo)
CREATE CONSTRAINT instructor_id_unique IF NOT EXISTS
FOR (ins:Instructor) REQUIRE ins.id IS UNIQUE;

// 7. Constraint para Projetos (Novo)
CREATE CONSTRAINT project_id_unique IF NOT EXISTS
FOR (p:Project) REQUIRE p.id IS UNIQUE;

// 8. Constraint para Certificados (Novo)
CREATE CONSTRAINT certificate_id_unique IF NOT EXISTS
FOR (cert:Certificate) REQUIRE cert.id IS UNIQUE;

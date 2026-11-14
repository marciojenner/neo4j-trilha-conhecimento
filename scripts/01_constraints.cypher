
// =====================================================================
// PROJETO: Knowledge Graph & Learning Path Engine (Neo4j)
// SCRIPT 01: Criação de Constraints e Índices de Unicidade
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
For (sk:Skill) REQUIRE sk.id IS UNIQUE;

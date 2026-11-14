
// =====================================================================
// PROJETO: Knowledge Graph & Learning Path Engine (Neo4j)
// SCRIPT 02: Carga Expandida de Dados, Novas Entidades e Topologia Avançada
// =====================================================================

// 1. Carga de Instructors, Cursos, Módulos, Aulas, Habilidades e Projetos
UNWIND [
  // Trilha 1: .NET Enterprise
  {courseId: 'CRS_01', courseTitle: 'Formação .NET Enterprise', category: 'Backend', instructorId: 'INST_01', instructorName: 'Márcio Jenner', modId: 'MOD_01', modTitle: 'Fundamentos de Lógica', lesId: 'LES_01', lesTitle: 'Variáveis e Tipos', skillId: 'SKILL_LOGIC', skillName: 'Lógica de Programação', skillDomain: 'Fundamentos', projId: 'PRJ_01', projTitle: 'Calculadora CLI em C#'},
  {courseId: 'CRS_01', courseTitle: 'Formação .NET Enterprise', category: 'Backend', instructorId: 'INST_01', instructorName: 'Márcio Jenner', modId: 'MOD_01', modTitle: 'Fundamentos de Lógica', lesId: 'LES_02', lesTitle: 'Estruturas Condicionais', skillId: 'SKILL_LOGIC', skillName: 'Lógica de Programação', skillDomain: 'Fundamentos', projId: 'PRJ_01', projTitle: 'Calculadora CLI em C#'},
  {courseId: 'CRS_01', courseTitle: 'Formação .NET Enterprise', category: 'Backend', instructorId: 'INST_01', instructorName: 'Márcio Jenner', modId: 'MOD_02', modTitle: 'Arquitetura C# & OOP', lesId: 'LES_03', lesTitle: 'Introdução ao C# Moderno', skillId: 'SKILL_CSHARP', skillName: 'C# Básico', skillDomain: 'Backend', projId: 'PRJ_02', projTitle: 'API RESTful com ASP.NET Core'},
  {courseId: 'CRS_01', courseTitle: 'Formação .NET Enterprise', category: 'Backend', instructorId: 'INST_01', instructorName: 'Márcio Jenner', modId: 'MOD_02', modTitle: 'Arquitetura C# & OOP', lesId: 'LES_04', lesTitle: 'LINQ e Collections', skillId: 'SKILL_CSHARP', skillName: 'C# Avançado', skillDomain: 'Backend', projId: 'PRJ_02', projTitle: 'API RESTful com ASP.NET Core'},
  {courseId: 'CRS_01', courseTitle: 'Formação .NET Enterprise', category: 'Backend', instructorId: 'INST_01', instructorName: 'Márcio Jenner', modId: 'MOD_03', modTitle: 'Persistência de Dados', lesId: 'LES_05', lesTitle: 'Entity Framework Core', skillId: 'SKILL_EF', skillName: 'Entity Framework Core', skillDomain: 'Database', projId: 'PRJ_02', projTitle: 'API RESTful com ASP.NET Core'},

  // Trilha 2: Bancos de Dados em Grafos
  {courseId: 'CRS_02', courseTitle: 'Neo4j & Graph Databases Masterclass', category: 'Database', instructorId: 'INST_02', instructorName: 'Expert Neo4j', modId: 'MOD_10', modTitle: 'Fundamentos de Grafos', lesId: 'LES_20', lesTitle: 'Propriedades e Cypher Básico', skillId: 'SKILL_GRAPH', skillName: 'Noções de Grafos', skillDomain: 'Database', projId: 'PRJ_10', projTitle: 'Modelagem de Rede Social em Grafo'},
  {courseId: 'CRS_02', courseTitle: 'Neo4j & Graph Databases Masterclass', category: 'Database', instructorId: 'INST_02', instructorName: 'Expert Neo4j', modId: 'MOD_11', modTitle: 'GraphRAG e IA', lesId: 'LES_21', lesTitle: 'Integração de LLMs com Neo4j', skillId: 'SKILL_GRAPHRAG', skillName: 'GraphRAG', skillDomain: 'Artificial Intelligence', projId: 'PRJ_10', projTitle: 'Modelagem de Rede Social em Grafo'}
] AS row

// Criação de Entidades Principais de Forma Idempotente (MERGE)
MERGE (ins:Instructor {id: row.instructorId})
ON CREATE SET ins.name = row.instructorName

MERGE (c:Course {id: row.courseId})
ON CREATE SET c.title = row.courseTitle, c.category = row.category

MERGE (m:Module {id: row.modId})
ON CREATE SET m.title = row.modTitle

MERGE (l:Lesson {id: row.lesId})
ON CREATE SET l.title = row.lesTitle

MERGE (sk:Skill {id: row.skillId})
ON CREATE SET sk.name = row.skillName, sk.domain = row.skillDomain

MERGE (p:Project {id: row.projId})
ON CREATE SET p.title = row.projTitle

// Construção da Topologia e Relacionamentos Estruturais
MERGE (ins)-[:TEACHES_COURSE]->(c)
MERGE (c)-[:HAS_MODULE]->(m)
MERGE (m)-[:CONTAINS_LESSON]->(l)
MERGE (c)-[:TEACHES_SKILL]->(sk)
MERGE (c)-[:HAS_PROJECT]->(p);


// 2. Estabelecendo Árvore de Pré-requisitos Complexa entre Habilidades (Skill Trees)
MATCH (skLogic:Skill {id: 'SKILL_LOGIC'})
MATCH (skCsharp:Skill {id: 'SKILL_CSHARP'})
MATCH (skEf:Skill {id: 'SKILL_EF'})
MATCH (skGraph:Skill {id: 'SKILL_GRAPH'})
MATCH (skGraphRag:Skill {id: 'SKILL_GRAPHRAG'})

MERGE (skLogic)-[:PREREQUISITE_FOR]->(skCsharp)
MERGE (skCsharp)-[:PREREQUISITE_FOR]->(skEf)
MERGE (skLogic)-[:PREREQUISITE_FOR]->(skGraph)
MERGE (skGraph)-[:PREREQUISITE_FOR]->(skGraphRag);


// 3. Criando Certificações Vinculadas aos Cursos
MERGE (cert1:Certificate {id: 'CERT_CRS_01'})
ON CREATE SET cert1.title = 'Certified .NET Enterprise Specialist'
MERGE (c1:Course {id: 'CRS_01'})
MERGE (c1)-[:ISSUES_CERTIFICATE]->(cert1);


// 4. Criando Alunos, Matrículas, Progresso e Conquistas
MERGE (st:Student {id: 'ST_099'})
ON CREATE SET st.name = 'Márcio Jenner', st.email = 'marcio@nexus.dev', st.level = 'Senior'

MATCH (cNet:Course {id: 'CRS_01'})
MATCH (cGraph:Course {id: 'CRS_02'})
MERGE (st)-[:ENROLLED_IN]->(cNet)
MERGE (st)-[:ENROLLED_IN]->(cGraph);

// Registrando o progresso de aulas concluídas pelo Aluno
MATCH (st:Student {id: 'ST_099'})
MATCH (l:Lesson {id: 'LES_01'})
MERGE (st)-[comp1:COMPLETED_LESSON]->(l)
ON CREATE SET comp1.completedAt = datetime('2026-10-01T08:30:00')

MATCH (st:Student {id: 'ST_099'})
MATCH (l:Lesson {id: 'LES_02'})
MERGE (st)-[comp2:COMPLETED_LESSON]->(l)
ON CREATE SET comp2.completedAt = datetime('2026-10-02T14:15:00');

// Registrando Submissão de Projeto e Emissão de Certificado
MATCH (st:Student {id: 'ST_099'})
MATCH (proj:Project {id: 'PRJ_01'})
MERGE (st)-[sub:SUBMITTED_PROJECT {status: 'Approved'}]->(proj)
ON CREATE SET sub.submittedAt = datetime('2026-10-03T18:00:00');

MATCH (st:Student {id: 'ST_099'})
MATCH (cert:Certificate {id: 'CERT_CRS_01'})
MERGE (st)-[earn:EARNED_CERTIFICATE]->(cert)
ON CREATE SET earn.earnedAt = datetime('2026-10-03T19:00:00');

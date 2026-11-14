# neo4j-trilha-conhecimento
Motor de grafos voltado a ecossistemas educacionais construído em Neo4j, explorando modelagem avançada de relacionamentos, caminhos de pré-requisitos e GraphRAG readiness.

// =====================================================================
// PROJETO: Knowledge Graph & Learning Path Engine (Neo4j)
// SCRIPT 03: Consultas de Negócio e Análises Avançadas de Grafos
// =====================================================================

// 1. ANÁLISE DE TRILHA DE PRÉ-REQUISITOS (Skill Tree Deep Traversal)
// Qual é o caminho lógico de aprendizado desde os Fundamentos de Lógica 
// até tecnologias avançadas como GraphRAG (IA)?
MATCH path = (start:Skill {id: 'SKILL_LOGIC'})-[:PREREQUISITE_FOR*]->(target:Skill {id: 'SKILL_GRAPHRAG'})
RETURN path;


// 2. MAPA DE INSTRUTORES E CURSOS MINISTRADOS
// Quais instrutores lecionam quais formações e quais habilidades são desenvolvidas?
MATCH (ins:Instructor)-[:TEACHES_COURSE]->(c:Course)-[:TEACHES_SKILL]->(sk:Skill)
RETURN ins.name AS Instrutor, 
       c.title AS Curso, 
       c.category AS Categoria, 
       sk.name AS HabilidadeEnsinada;


// 3. PROGRESSO E STATUS DO ESTUDANTE EM TEMPO REAL
// Qual é o percentual de conclusão de aulas e o status dos projetos do aluno ST_099?
MATCH (s:Student {id: 'ST_099'})-[:ENROLLED_IN]->(c:Course)-[:HAS_MODULE]->(:Module)-[:CONTAINS_LESSON]->(l:Lesson)
OPTIONAL MATCH (s)-[comp:COMPLETED_LESSON]->(l)
WITH c, COUNT(l) AS TotalAulas, COUNT(comp) AS AulasConcluidas
MATCH (st:Student {id: 'ST_099'})-[:ENROLLED_IN]->(c)-[:HAS_PROJECT]->(p:Project)
OPTIONAL MATCH (st)-[sub:SUBMITTED_PROJECT]->(p)
RETURN c.title AS Curso,
       TotalAulas,
       AulasConcluidas,
       round((toFloat(AulasConcluidas) / TotalAulas) * 100, 2) AS PercentualConclusaoAulas,
       p.title AS ProjetoPratico,
       coalesce(sub.status, 'Não Iniciado') AS StatusProjeto;


// 4. RECOMENDAÇÃO INTELIGENTE DE PRÓXIMAS HABILIDADES (Collaborative/Path Recommendation)
// Quais são as próximas habilidades que o aluno pode estudar baseando-se 
// nos pré-requisitos das competências que ele já domina?
MATCH (s:Student {id: 'ST_099'})-[:ENROLLED_IN]->(:Course)-[:TEACHES_SKILL]->(currentSkill:Skill)
MATCH (currentSkill)-[:PREREQUISITE_FOR]->(nextSkill:Skill)
RETURN nextSkill.name AS ProximaHabilidadeSugerida, 
       nextSkill.domain AS DominioTecnologico;


// 5. AUDITORIA DE CERTIFICAÇÕES EMITIDAS
// Quais alunos conquistaram certificados e quais cursos validaram essa conquista?
MATCH (st:Student)-[earn:EARNED_CERTIFICATE]->(cert:Certificate)<-[:ISSUES_CERTIFICATE]-(c:Course)
RETURN st.name AS Aluno,
       st.level AS NivelEstudante,
       cert.title AS CertificadoConquistado,
       c.title AS CursoOrigem,
       earn.earnedAt AS DataConquista;

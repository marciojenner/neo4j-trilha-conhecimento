# neo4j-trilha-conhecimento
Motor de grafos voltado a ecossistemas educacionais construído em Neo4j, explorando modelagem avançada de relacionamentos, caminhos de pré-requisitos e GraphRAG readiness.

### 📂 Arquivos do Repositório
* 📥 [01_Constraints e Índices](scripts/01_constraints.cypher) — Garante a unicidade dos nós e otimiza a performance.
* 📊 [02_Carga de Dados do Grafo](scripts/02_load_data.cypher) — Popula o banco com entidades, relacionamentos e propriedades temporais.
* 🔍 [03_Consultas de Negócio (Cypher)](scripts/03_business_queries.cypher) — Executa análises de caminhos, métricas de progresso e recomendações.

```cypher
// Exemplo de código Cypher
graph TD
    %% Estilo dos Nós
    classDef student fill:#4A90E2,stroke:#fff,stroke-width:2px,color:#fff;
    classDef course fill:#50E3C2,stroke:#fff,stroke-width:2px,color:#333;
    classDef module fill:#F5A623,stroke:#fff,stroke-width:2px,color:#fff;
    classDef lesson fill:#F8E71C,stroke:#fff,stroke-width:2px,color:#333;
    classDef skill fill:#7B61FF,stroke:#fff,stroke-width:2px,color:#fff;
    classDef instructor fill:#BD10E0,stroke:#fff,stroke-width:2px,color:#fff;
    classDef project fill:#B8E986,stroke:#fff,stroke-width:2px,color:#333;
    classDef certificate fill:#D0021B,stroke:#fff,stroke-width:2px,color:#fff;

    %% Entidades
    ST[(":Student")]:::student
    INS[(":Instructor")]:::instructor
    CRS[(":Course")]:::course
    MOD[(":Module")]:::module
    LES[(":Lesson")]:::lesson
    SK[(":Skill")]:::skill
    PRJ[(":Project")]:::project
    CERT[(":Certificate")]:::certificate

    %% Relacionamentos
    INS -->|TEACHES_COURSE| CRS
    CRS -->|HAS_MODULE| MOD
    MOD -->|CONTAINS_LESSON| LES
    CRS -->|TEACHES_SKILL| SK
    SK -->|PREREQUISITE_FOR| SK
    CRS -->|HAS_PROJECT| PRJ
    CRS -->|ISSUES_CERTIFICATE| CERT
    
    ST -->|ENROLLED_IN| CRS
    ST -->|COMPLETED_LESSON| LES
    ST -->|SUBMITTED_PROJECT| PRJ
    ST -->|EARNED_CERTIFICATE| CERT

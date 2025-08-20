 # Sistema de Gestão de Ordens de Serviço (SGOS)

Este projeto foi desenvolvido como parte de uma prova técnica para a vaga de Desenvolvedor de Sistemas, com foco em demonstrar a capacidade de modelar, implementar e documentar uma aplicação completa de gestão.

---

### **1. Tecnologias e Ambiente**

O projeto SGOS foi construído com as seguintes tecnologias:

* **Linguagem/IDE:** Delphi 12.1 Athens Community Edition.
* **Banco de Dados:** Firebird 4.0.6.
* **Componente de Acesso:** FireDAC.
* **Componente de Relatório:** FastReport.

---

### **2. Como Executar**

Siga os passos abaixo para configurar e rodar a aplicação:

1.  **Configuração do Banco de Dados:**
    * Certifique-se de que o Firebird Server 4.0.6 está instalado e rodando.
    * Execute o script SQL `CREATE.sql` para criar as tabelas e os índices necessários.

2.  **Configuração da Conexão:**
    * No DataModule da aplicação, ajuste a string de conexão do componente FireDAC.
    * A string de conexão deve apontar para o local do seu banco de dados (.fdb). Exemplo de string: `DriverID=FB;Database=C:\caminho\para\seu\banco.fdb;User_Name=SYSDBA;Password=masterkey;`

3.  **Compilação e Execução:**
    * Abra o projeto `SGOS.dpr` no Delphi.
    * Compile e execute a aplicação (ou utilize o arquivo `SGOS.exe` na pasta `bin`).

---

### **3. Funcionalidade Extra (Não-CRUD)**

 Conforme os requisitos, a funcionalidade obrigatória não-CRUD implementada foi o **Cálculo de SLA / Atraso**.

*  **Lógica:** O sistema verifica se a Data de Fechamento de uma Ordem de Serviço não está preenchida e se a data atual é superior à Data Prevista.  Se ambas as condições forem verdadeiras, a OS é considerada em atraso.
*  **Visualização:** Ordens de Serviço em atraso são destacadas visualmente (ícone/cor) para fácil identificação.
*  **Dashboard:** Um contador simples no topo da tela principal exibe o total de Ordens de Serviço por status (Abertas, Em Andamento, Concluídas e Em Atraso).

---

### **4. Decisões Arquiteturais**

*  **Separação de Camadas:** A arquitetura do projeto segue a recomendação de separar as camadas de UI (forms), Acesso a Dados (DataModule) e Regras de Negócio (unit separada para cálculos).
*  **Gerenciamento de Transações:** Para garantir a consistência dos dados, transações explícitas são usadas ao salvar uma Ordem de Serviço e seus Itens relacionados.

---

### **5. Limitações Conhecidas**

_(A listar, se houver.)_

---

### **6. Uso de Inteligência Artificial**

O esqueleto do código e a estrutura do projeto foram gerados com o auxílio de IA para otimizar o tempo de desenvolvimento. Todo o código foi revisado, adaptado e compreendido antes da entrega.

---

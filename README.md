# Sistema de Gestão Comercial - AcrilService

Projeto desenvolvido para a empresa **AcrilService**.O sistema foi criado como parte da disciplina de **Projeto Integrador com ênfase em Banco de Dados** do curso de Bacharelado em Sistemas de Informação no **Centro Universitário Senac**.

## 🎯 Objetivo

O projeto visa solucionar a dificuldade do cliente em reunir informações de vendas de forma clara e acessível, fator que dificultava a tomada de decisões estratégicas.

Os principais objetivos do sistema incluem:
* Registrar clientes e suas respectivas vendas.
* Centralizar dados para permitir análises futuras e decisões mais assertivas.
* Avaliar a satisfação do cliente quanto ao site, serviços e produtos.
* Atender a **ODS 8 (Trabalho Decente e Crescimento Econômico)**, otimizando processos e promovendo eficiência empresarial.

## 🛠️ Arquitetura e Tecnologias

O sistema utiliza a **Arquitetura Hexagonal** para isolar o núcleo da aplicação (model) de tecnologias externas, como banco de dados e interfaces gráficas, garantindo baixo acoplamento e alta escalabilidade.

* **Linguagem:** Java.
* **Banco de Dados:** SQL (MySQL/MySQL Workbench).
* **Interface Gráfica:** Java Swing.

## 📦 Módulos do Sistema

O sistema é composto por cinco módulos principais integrados:

### 1. Módulo Cliente
Gerenciamento de dados cadastrais de pessoas físicas e jurídicas.
* **Funcionalidades:** Cadastro, consulta, atualização e ativação/inativação de clientes.
* **Dados:** Nome, código, tipo (CPF/CNPJ), endereço completo, e-mail, telefone e status (Ativo/Inativo).

### 2. Módulo Produto
Controle do catálogo de itens da empresa.
***Funcionalidades:** Cadastro, consulta, atualização de valores e exclusão de produtos.
***Dados:** Nome, código e valor do produto.

### 3. Módulo Orçamento
Gestão de propostas comerciais prévias às vendas.
* **Funcionalidades:** Criação, consulta e alteração de status (Aprovado, Rejeitado, Expirado ou Em Avaliação).
* **Dados:** Código, data de criação, validade, cliente responsável, produtos cotados, valor total e descontos.

### 4. Módulo Venda
Processamento das transações geradas a partir de orçamentos aprovados.
* **Funcionalidades:** Criação, consulta e atualização de status de pagamento.
* **Dados:** Código, data de criação, data de conclusão, prazo para pagamento e status (Pendente, Concluído ou Vencido).

### 5. Módulo Avaliação
Sistema de feedback para mensurar a qualidade do serviço.
* **Funcionalidades:** Criação, alteração, exclusão e consulta de avaliações (por venda ou por produto).
* **Dados:** Nota, título, descrição e data de criação.

## 🗃️ Modelagem de Dados

O banco de dados segue um modelo relacional, estruturado da seguinte forma:
* **Cliente:** Relaciona-se com múltiplos endereços e e-mails.
* **Orçamento:** Vinculado a um cliente e contém múltiplos produtos (relação N:N através da entidade `Orcamento_Produto`).
* **Venda:** Gerada a partir de um orçamento único (1:1).
* **Avaliação:** Vinculada diretamente a uma venda (1:1).


## Pré-requisitos

* **Java**
* **Maven**
* **Docker**

```bash
docker info
mvn compile exec:java "-Dexec.mainClass=View.Swing.MainDocker"
```
---

<p align="center">
<img width="749" height="431" alt="Captura de tela 2026-01-05 155030" src="https://github.com/user-attachments/assets/9b609cf7-08fc-467c-81c8-2ef2bc9699b4" />
<img width="861" height="566" alt="Captura de tela 2026-01-05 155111" src="https://github.com/user-attachments/assets/4a0d3da1-0497-4de2-93d2-6d98d4b6ec94" />
<img width="411" height="334" alt="Captura de tela 2026-01-05 155842" src="https://github.com/user-attachments/assets/15cfb9f7-ec83-41b7-941e-395ddb924382" />
</p>

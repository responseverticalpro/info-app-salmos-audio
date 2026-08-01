# Harpa de Davi Landing Page Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Criar um `index.html` autônomo, responsivo e acessível para visualização local da página de vendas Harpa de Davi.

**Architecture:** Um documento HTML semântico contém os 11 blocos na ordem exigida, CSS mobile-first no `<head>` e JavaScript vanilla ao fim do `<body>`. Um script PowerShell independente valida estrutura, textos, placeholders e comportamento declarativo antes da inspeção visual.

**Tech Stack:** HTML5, CSS3, SVG inline, JavaScript vanilla e PowerShell para validação local.

## Global Constraints

- Um único arquivo de produto: `index.html`, sem frameworks e sem etapa de publicação.
- Cores principais: `#0D0D0D`, `#1A1A1A`, `#C9A96E`, `#F5F5F5`, `#B0B0B0`, `#2E7D32` e `#FFFFFF`.
- Playfair Display para títulos e Inter para corpo, com fallbacks locais.
- Layout mobile-first funcional em 375 px e desktop.
- Provas sociais, número de usuários, checkout, plataforma e áudios permanecem explicitamente demonstrativos.
- Ordem obrigatória dos IDs: `hero`, `prova-social-1`, `por-que-audio`, `entregaveis`, `versiculos`, `oferta`, `garantia`, `prova-social-2`, `faq`, `cta-final`, `footer`.

---

### Task 1: Contrato estrutural automatizado

**Files:**
- Create: `tests/validate-page.ps1`
- Test: `tests/validate-page.ps1`

**Interfaces:**
- Consumes: caminho `index.html` na raiz do projeto.
- Produces: exit code 0 quando os requisitos estruturais forem atendidos; exceção descritiva em caso contrário.

- [ ] **Step 1: Criar o teste estrutural que carrega `index.html` e exige os 11 IDs em ordem**
- [ ] **Step 2: Exigir as quatro fontes MP3, seis itens de FAQ, transparência de conteúdo demonstrativo, media query e redução de movimento**
- [ ] **Step 3: Executar `powershell -ExecutionPolicy Bypass -File tests/validate-page.ps1` e confirmar falha por ausência de `index.html`**

### Task 2: Documento completo e estilos responsivos

**Files:**
- Create: `index.html`
- Test: `tests/validate-page.ps1`

**Interfaces:**
- Consumes: o contrato de validação da Task 1.
- Produces: página local autônoma com seções, estilos, SVGs, players, CTAs e conteúdo completo.

- [ ] **Step 1: Criar estrutura semântica com os 11 blocos e todos os textos aprovados**
- [ ] **Step 2: Adicionar tokens de cor, tipografia, espaçamento, cards e estados de foco/hover no `<style>`**
- [ ] **Step 3: Adicionar SVGs inline, quatro players e placeholders editoriais visíveis**
- [ ] **Step 4: Implementar grades mobile-first e breakpoints desktop sem overflow horizontal**
- [ ] **Step 5: Executar o validador e corrigir até obter exit code 0**

### Task 3: FAQ acessível e verificação final

**Files:**
- Modify: `index.html`
- Test: `tests/validate-page.ps1`

**Interfaces:**
- Consumes: botões `.faq-question` e painéis `.faq-answer` dentro de `#faq`.
- Produces: accordion operável por mouse e teclado, com `aria-expanded` sincronizado e apenas um painel aberto por vez.

- [ ] **Step 1: Fazer o validador exigir `aria-expanded`, `aria-controls` e o listener de clique**
- [ ] **Step 2: Executar o teste e confirmar falha pelo comportamento ausente**
- [ ] **Step 3: Implementar o JavaScript mínimo para alternar o painel e fechar os demais**
- [ ] **Step 4: Executar novamente o validador e confirmar exit code 0**
- [ ] **Step 5: Inspecionar visualmente a página em 375 px e desktop, verificando conteúdo, foco, contraste e overflow**

## Self-review

O plano cobre os 11 blocos, responsividade, placeholders, acessibilidade, FAQ, players, cores e visualização local. A publicação foi removida do escopo conforme solicitado. Não há dependências de build nem integração com checkout.

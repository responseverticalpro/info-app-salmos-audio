# Design — Página de vendas Harpa de Davi

## Objetivo

Criar uma página de vendas responsiva, em português do Brasil, para o aplicativo devocional cristão Harpa de Davi. O produto oferece acesso vitalício por R$ 37, com foco principal nos 150 Salmos cantados em áudio e recursos complementares de prática devocional. O público prioritário são cristãos brasileiros, homens e mulheres, acima de 35 anos.

## Entrega e restrições

- Um único arquivo `index.html`, sem frameworks.
- HTML semântico, CSS dentro de `<style>` e JavaScript vanilla no próprio arquivo.
- Design mobile-first, otimizado inicialmente para 375 px e expandido para tablet e desktop.
- Ordem exata dos 11 blocos definida no briefing, cada um com seu ID obrigatório.
- Google Fonts será a única dependência visual externa: Playfair Display nos títulos e Inter no corpo.
- Os quatro áudios usarão os caminhos placeholder `salmo23.mp3`, `salmo91.mp3`, `salmo121.mp3` e `salmo150.mp3`.
- Links de checkout, plataforma de pagamento, quantidade de clientes e provas sociais serão placeholders claramente identificados.

## Direção visual

A estética será de “santuário digital”: reverente, sofisticada e acolhedora, sem excesso decorativo. O fundo principal será `#0D0D0D`, cards `#1A1A1A`, dourado `#C9A96E`, texto principal `#F5F5F5`, texto secundário `#B0B0B0` e CTAs verdes `#2E7D32` com texto branco.

O dourado será usado com parcimônia em bordas, ícones, pequenos ornamentos e títulos estratégicos. Gradientes, brilhos e sombras serão sutis. O espaçamento vertical mínimo entre seções será de 60 px, com largura de leitura controlada e tipografia confortável para o público 35+.

## Arquitetura da página

1. `#hero`: headline editorial, subheadline, quatro players em cards e fechamento emocional.
2. `#prova-social-1`: seis exemplos de depoimentos em composição inspirada em mensagens, acompanhados de aviso visível de conteúdo demonstrativo.
3. `#por-que-audio`: três benefícios em cards com SVGs inline de cérebro, fones e harpa.
4. `#entregaveis`: seis cards horizontais com ícone, título e descrição.
5. `#versiculos`: três citações bíblicas em fundo marrom-dourado profundo.
6. `#oferta`: card central com ancoragem, preço, garantia, CTA e lista do conteúdo incluso.
7. `#garantia`: selo em SVG, garantia de sete dias e CTA secundário.
8. `#prova-social-2`: quatro avaliações demonstrativas em formato diferente, com aviso de placeholder e estrelas decorativas.
9. `#faq`: seis perguntas expansíveis.
10. `#cta-final`: encerramento emocional com gradiente dourado discreto e CTA principal.
11. `#footer`: produto, texto legal, disclaimer e copyright.

## Componentes e comportamento

Os botões usarão uma classe visual comum e apontarão para um link placeholder de checkout, identificado no HTML para substituição. Haverá estados de hover, foco visível e pressionamento, respeitando `prefers-reduced-motion`.

Os players usarão `<audio controls preload="metadata">`, com texto alternativo caso o navegador não suporte áudio. Os ícones serão SVG inline com `aria-hidden="true"` quando decorativos.

O FAQ será construído com estrutura semanticamente expansível e aprimorado com JavaScript vanilla. Os controles deverão funcionar por teclado, expor estado aberto/fechado e manter o conteúdo acessível mesmo se o JavaScript falhar.

O documento terá rolagem suave, desativada para usuários que preferem movimento reduzido. Não haverá menu fixo, contadores, pop-ups, escassez artificial ou animações pesadas.

## Responsividade

- Base de 375 px: uma coluna para conteúdo geral; os seis cards demonstrativos do primeiro bloco social ficam em duas colunas conforme solicitado.
- Tablets: ampliação gradual de espaçamento, tipografia e largura dos cards.
- Desktop: container central; hero com largura de leitura controlada; players em grade; benefícios em três colunas; prova social em três colunas; avaliações em duas ou quatro colunas conforme espaço disponível.
- Áreas clicáveis terão tamanho confortável e não dependerão apenas de cor para indicar interação.

## Transparência editorial

Depoimentos fictícios não serão apresentados como relatos reais. Os blocos sociais receberão uma indicação como “Exemplos de apresentação — substitua por depoimentos reais antes de publicar”. A quantidade de cristãos permanecerá como marcador editável, sem sugerir uma base real inexistente.

A frase sobre Davi será preservada como gancho retórico, mas o texto de apoio evitará alegar com certeza que ele compôs ou cantou todos os 150 Salmos. A alegação de que “neurocientistas comprovam” será substituída por formulação moderada sobre música, memória e emoção, sem atribuir comprovação específica não fornecida. Comparações de preço serão apresentadas como referências a validar antes da publicação.

## Tratamento de falhas e placeholders

- Se um MP3 não existir, o player continuará visível e o HTML incluirá comentário indicando onde inserir o arquivo real.
- CTAs usarão `href="#"` ou marcador equivalente com comentário explícito para inserir a URL de checkout.
- `[Plataforma]`, `[NÚMERO REAL]` e dados comerciais não confirmados permanecerão claramente marcados no código e na interface quando necessário.
- Não haverá submissão de formulário nem armazenamento de dados pessoais.

## Validação

A entrega será verificada por:

- inspeção da presença e ordem dos 11 IDs obrigatórios;
- teste do FAQ por mouse e teclado;
- inspeção visual em 375 px e em largura desktop;
- verificação de overflow horizontal, contraste, foco e redução de movimento;
- validação básica da estrutura HTML;
- busca por placeholders para facilitar a substituição antes da publicação.

## Critério de conclusão

O trabalho estará concluído quando o `index.html` abrir diretamente no navegador, reproduzir toda a estrutura solicitada, adaptar-se sem quebra a 375 px e desktop, oferecer FAQ funcional e apresentar de forma explícita todos os conteúdos ainda demonstrativos ou não validados.

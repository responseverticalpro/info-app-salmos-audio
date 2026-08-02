$ErrorActionPreference = 'Stop'
$pagePath = Join-Path (Split-Path $PSScriptRoot -Parent) 'index.html'

if (-not (Test-Path -LiteralPath $pagePath)) {
    throw 'index.html não encontrado na raiz do projeto.'
}

$html = Get-Content -LiteralPath $pagePath -Raw -Encoding UTF8
$requiredIds = @(
    'hero', 'prova-social-1', 'por-que-audio', 'versiculos', 'entregaveis-beneficios',
    'oferta', 'garantia', 'autoridade', 'faq', 'cta-final', 'footer'
)

$lastPosition = -1
foreach ($id in $requiredIds) {
    $token = 'id="' + $id + '"'
    $position = $html.IndexOf($token, [System.StringComparison]::Ordinal)
    if ($position -lt 0) { throw "ID obrigatório ausente: $id" }
    if ($position -le $lastPosition) { throw "ID fora da ordem obrigatória: $id" }
    $lastPosition = $position
}

foreach ($audio in @('previa_salmo27.MP3', 'previa_salmo34.MP3', 'previa_salmo121.MP3')) {
    if (-not $html.Contains($audio)) { throw "Áudio placeholder ausente: $audio" }
}
if ([regex]::Matches($html, 'class="audio-card card"').Count -ne 3) {
    throw 'O hero precisa conter exatamente 3 players.'
}
if (-not $html.Contains('.audio-header{display:flex')) { throw 'Novo cabeçalho premium de áudio ausente.' }
if (-not $html.Contains('.audio-grid{grid-template-columns:repeat(3,1fr)}')) { throw 'Grade de áudio desktop/tablet incorreta.' }

$checks = @{
    'sete perguntas do FAQ' = ([regex]::Matches($html, 'class="faq-question"').Count -eq 7)
    'layout responsivo' = $html.Contains('@media (min-width:')
    'redução de movimento' = $html.Contains('prefers-reduced-motion')
    'estado acessível do FAQ' = $html.Contains('aria-expanded="false"')
    'relação entre pergunta e resposta' = $html.Contains('aria-controls="faq-answer-1"')
    'comportamento JavaScript do FAQ' = $html.Contains("addEventListener('click'")
    'otimização dedicada para mobile' = $html.Contains('@media (max-width:430px)')
    'área de toque mínima' = $html.Contains('min-height:48px')
    'CTA mobile em largura total' = $html.Contains('.btn{width:100%;')
    'quebra segura de palavras' = $html.Contains('overflow-wrap:anywhere')
}

$newCopy = @(
    'Creia. Prospere.',
    'Por que ouvir os Salmos muda a sua vida',
    'voltar pra perto. Comece agora.',
    'Salmos tocam todos os dias'
)
foreach ($copy in $newCopy) {
    if (-not $html.Contains($copy)) { throw "Nova copy ausente: $copy" }
}

if ([regex]::Matches($html, 'class="verse card"').Count -ne 8) {
    throw 'A seção de benefícios precisa conter exatamente 8 cards verse card.'
}
if ([regex]::Matches($html, 'class="placeholder-note"').Count -ne 0) {
    throw 'As três notas placeholder devem ser removidas.'
}
$offerMatch = [regex]::Match($html, '<div class="offer-card card">([\s\S]*?)</div><ul class="included">')
if ($offerMatch.Success) { throw 'A lista included ainda está fora do offer-card.' }
if ($html.Contains('id="entregaveis"')) { throw 'A seção antiga entregaveis deve ser removida.' }
if (-not $html.Contains('APENAS 133 VAGAS')) { throw 'Badge de vagas ausente.' }
if (-not $html.Contains('id="promotion-date"')) { throw 'Data dinâmica da promoção ausente.' }
if (-not $html.Contains("toLocaleDateString('pt-BR')")) { throw 'Atualização automática da data ausente.' }
if (-not $html.Contains('faq-question-7')) { throw 'Sétima pergunta do FAQ ausente.' }
if (-not $html.Contains('30 dias de garantia incondicional')) { throw 'Garantia de 30 dias ausente.' }
if ([regex]::Matches($html, 'class="benefit-delivery"').Count -ne 6) { throw 'Nova seção precisa de 6 entregáveis.' }
if (-not $html.Contains('<img src="autoridade2_webp.webp" alt="Pastor Marcos Antunes" class="authority-photo" loading="lazy">')) {
    throw 'Nova foto da autoridade ausente.'
}
if ([regex]::Matches($html, 'class="authority-badge"').Count -ne 4) {
    throw 'A autoridade precisa conter exatamente 4 badges.'
}
foreach ($oldAuthorityClass in @('.authority-wrap', '.pastor-photo', '.authority-copy')) {
    if ($html.Contains($oldAuthorityClass)) { throw "Estilo antigo ainda existe: $oldAuthorityClass" }
}
if ($html.Contains('Playfair Display') -or $html.Contains('Playfair+Display')) { throw 'Playfair Display não deve mais ser carregada.' }
if (-not $html.Contains('Poppins:wght@600;700;800')) { throw 'Importação da Poppins ausente.' }
if (-not $html.Contains('h1{font-size:clamp(1.7rem,5.5vw,2.6rem)')) { throw 'Escala desktop do H1 incorreta.' }
if (-not $html.Contains('.section-title{font-size:clamp(1.4rem,4.5vw,2rem)')) { throw 'Escala dos títulos de seção incorreta.' }
if (-not $html.Contains('h1{font-size:clamp(1.5rem,7vw,1.9rem)')) { throw 'Escala mobile do H1 incorreta.' }
$emDash = [char]0x2014
$enDash = [char]0x2013
if ($html.Contains([string]$emDash) -or $html.Contains([string]$enDash)) {
    throw 'Ainda existem travessões Unicode no HTML.'
}
if (-not $html.Contains('Sua casa tem ouvido mais o barulho do mundo do que a voz de Deus?')) {
    throw 'Novo H1 do hero ausente.'
}
if (-not $html.Contains('3 minutos por dia.')) {
    throw 'Novo subtítulo do hero ausente.'
}
if (-not $html.Contains('transformando o seu ambiente e a sua vida.</p><p class="hero-cta-play">') -or
    -not $html.Contains('Aperte o play e escute como os Salmos podem transformar o seu dia:</p><div class="audio-grid">')) {
    throw 'Nova transição entre o subtítulo do hero e os players ausente.'
}
if ($html.Contains('3 minutos por dia. Ouça agora:')) {
    throw 'A chamada antiga Ouça agora ainda existe no subtítulo do hero.'
}
if (-not $html.Contains('.hero-cta-play{text-align:center;color:var(--gold-soft);font-size:clamp(.95rem,2.5vw,1.1rem);font-weight:700;margin:0 auto 24px;max-width:600px}')) {
    throw 'Estilo da nova chamada dos players ausente.'
}
if (-not $html.Contains('.hero-cta-play{font-size:.92rem;margin-bottom:20px}')) {
    throw 'Estilo mobile da nova chamada dos players ausente.'
}
if ($html.Contains('id="prova-social-2"')) { throw 'A segunda prova social ainda existe.' }
if ([regex]::Matches($html, 'class="carousel-slide"').Count -ne 4) {
    throw 'O carrossel precisa conter exatamente 4 slides.'
}
foreach ($testimonial in @('depoimento01.webp','depoimento02.webp','depoimento03.webp','depoimento04.webp')) {
    if (-not $html.Contains($testimonial)) { throw "Imagem de depoimento ausente: $testimonial" }
}
foreach ($oldSocialSelector in @('.wa-grid','.wa-card','.wa-name','.wa-bubble','.wa-time','.review-grid','.review','.stars')) {
    if ($html.Contains($oldSocialSelector)) { throw "Estilo social antigo ainda existe: $oldSocialSelector" }
}
if (-not $html.Contains('function updateCarousel()')) { throw 'JavaScript do carrossel ausente.' }
if (-not $html.Contains('.carousel-slide{flex:0 0 95%}')) { throw 'Largura mobile do depoimento incorreta.' }
if (-not $html.Contains('.carousel-slide{flex:0 0 calc(50% - 8px)}')) { throw 'Grade desktop de depoimentos incorreta.' }
if (-not $html.Contains('.carousel-track{flex-wrap:wrap;transition:none}')) { throw 'Quebra desktop do track ausente.' }
if (-not $html.Contains("return slides[0].offsetWidth + 16;")) { throw 'Gap do cálculo do carrossel incorreto.' }
if (-not $html.Contains("track.style.transform = 'translateX(0)';")) { throw 'Transform desktop não foi resetado.' }
$deadSelectors = @(
    '.deliverables', '.deliverable', '#entregaveis', '.placeholder-note',
    '.anchor', '.old-price', '.price', '.lifetime', '.included', '.pay-chip', '.payments'
)
foreach ($deadSelector in $deadSelectors) {
    $escapedSelector = [regex]::Escape($deadSelector)
    if ([regex]::IsMatch($html, $escapedSelector + '(?=[\s,{])')) {
        throw "Seletor morto ainda existe: $deadSelector"
    }
}
if ($html.Contains('--card-2:')) { throw 'Variável --card-2 ainda existe.' }
if (-not $html.Contains('html{overflow-x:hidden;')) { throw 'Proteção de overflow no html ausente.' }
if (-not $html.Contains('body{margin:0;min-width:320px;overflow-x:hidden;')) { throw 'Proteção de overflow no body ausente.' }
if (-not $html.Contains('#cta-final .btn{max-width:360px;')) { throw 'CTA final otimizado ausente.' }
if (-not $html.Contains('.authority-photo-wrap{flex:none;width:100%;min-height:0;max-height:none}')) {
    throw 'Wrapper mobile ainda limita a altura da foto da autoridade.'
}
if (-not $html.Contains('.authority-photo{height:auto;object-fit:contain}')) {
    throw 'Foto mobile ainda pode ser recortada.'
}
if ($html.Contains('class="carousel-arrow')) { throw 'Setas antigas do carrossel ainda existem.' }
if (-not $html.Contains('<div class="carousel-dots"></div>')) { throw 'Container de dots ausente.' }
if (-not $html.Contains("document.createElement('button')")) { throw 'Geração dinâmica dos dots ausente.' }
if (-not $html.Contains('.carousel-slide{flex:0 0 95%}')) { throw 'Largura mobile do carrossel incorreta.' }
if (-not $html.Contains('white-space:nowrap')) { throw 'Badge vitalício ainda pode quebrar linha.' }
$authorityBadgesMatch = [regex]::Match($html, '<div class="authority-badges">([\s\S]*?)</div><p class="authority-text">')
if ($authorityBadgesMatch.Groups[1].Value.Contains('<strong>')) {
    throw 'Os badges da autoridade ainda contêm strong.'
}
$expectedBadgeTexts = @(
    '</span> 22 anos no minist',
    '</span> 4.000+ horas',
    '</span> 150 Salmos gravados',
    '</span> 130+ igrejas'
)
foreach ($badgeText in $expectedBadgeTexts) {
    if (-not $html.Contains($badgeText)) { throw 'Texto contínuo do badge ausente.' }
}
$bodyHtml = [regex]::Match($html, '<body>([\s\S]*?)</body>').Groups[1].Value
$bodyWithoutScript = [regex]::Replace($bodyHtml, '<script>[\s\S]*?</script>', '')
if ([regex]::IsMatch($bodyWithoutScript, '<(span|strong|em|a)\b[^>]*>[^<]*[\r\n]+[^<]*</\1>')) {
    throw 'Quebra de linha encontrada dentro de tag inline.'
}
foreach ($textNodeMatch in [regex]::Matches($bodyWithoutScript, '>([^<]+)<')) {
    $textNode = $textNodeMatch.Groups[1].Value
    if ([regex]::IsMatch($textNode, '\S {2,}\S')) {
        throw 'Espaço duplicado encontrado em texto visível.'
    }
}
$images = [regex]::Matches($html, '<img\s[^>]*>')
foreach ($imageTag in $images) {
    if (-not $imageTag.Value.Contains('loading="lazy"')) { throw 'Imagem sem lazy loading.' }
}
if (-not $html.Contains('font:800 clamp(3.2rem,12vw,4.5rem)/1 "Poppins",sans-serif')) {
    throw 'Escala ampliada do preço da oferta ausente.'
}
if (-not $html.Contains('@keyframes pulse-promo')) {
    throw 'Animação da promoção ausente.'
}
if (-not $html.Contains('animation:pulse-promo 2s ease-in-out infinite')) {
    throw 'Animação não aplicada ao texto promocional.'
}
if (-not $html.Contains('<img src="garantia30_webp.webp" alt="Garantia de 30 dias" class="seal-img" loading="lazy">')) {
    throw 'Imagem da garantia ausente.'
}
if ($html.Contains('<svg class="seal"')) { throw 'SVG antigo da garantia ainda existe.' }
if (-not $html.Contains('.seal-img{display:block;width:120px;height:auto;margin:0 auto 22px}')) {
    throw 'Estilo da imagem de garantia ausente.'
}
if (-not $html.Contains('<div class="authority-card card"><div class="authority-layout">')) {
    throw 'Layout da autoridade não começa diretamente dentro do card.'
}
if (-not $html.Contains('<img src="autoridade2_webp.webp" alt="Pastor Marcos Antunes" class="authority-photo" loading="lazy">')) {
    throw 'Nova foto da autoridade ausente.'
}
if ($html.Contains('authority-headline') -or $html.Contains('Quem sou eu?')) {
    throw 'O título Quem sou eu ainda existe na página.'
}
if (-not $html.Contains('.authority-photo-wrap{flex:0 0 35%;display:flex;align-items:flex-end;overflow:hidden}')) {
    throw 'A foto da autoridade não ocupa 35% do card no desktop.'
}
if (-not $html.Contains('.authority-photo{width:100%;height:auto;object-fit:contain;object-position:center top;display:block}')) {
    throw 'A foto da autoridade não está configurada para aparecer inteira.'
}
if ($html.Contains('.authority-photo-wrap{flex:0 0 280px') -or $html.Contains('object-fit:cover')) {
    throw 'O layout antigo com foto cortada ainda existe.'
}
$checkoutUrl = 'https://lastlink.com/p/CCB863B59/checkout-payment/'
if ([regex]::Matches($html, 'href="' + [regex]::Escape($checkoutUrl) + '"').Count -ne 3) {
    throw 'Exatamente três CTAs devem apontar para o checkout.'
}
$buttonLinks = [regex]::Matches($html, '<a class="[^"]*btn[^"]*" href="([^"]+)"')
foreach ($buttonLink in $buttonLinks) {
    $destination = $buttonLink.Groups[1].Value
    if ($destination -ne $checkoutUrl -and $destination -ne '#oferta') {
        throw "Botão com destino inválido: $destination"
    }
}

foreach ($entry in $checks.GetEnumerator()) {
    if (-not $entry.Value) { throw "Requisito ausente: $($entry.Key)" }
}

Write-Output 'VALIDATION_OK: estrutura, conteúdo, responsividade e FAQ encontrados.'

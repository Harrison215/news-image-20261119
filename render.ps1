Add-Type -AssemblyName System.Drawing
$W=1024; $H=1024
$bmp=[System.Drawing.Bitmap]::new($W,$H)
$g=[System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode=[System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint=[System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::FromArgb(246,241,231))
$ink='#252321'; $muted='#68645D'; $red='#A64532'; $blue='#345B78'; $gold='#C68A37'; $teal='#3E817B'; $paper='#FFFDF8'; $rule='#CFC7B9'
function Brush([string]$c){ [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml($c)) }
function Pen([string]$c,[float]$w=1){ [System.Drawing.Pen]::new([System.Drawing.ColorTranslator]::FromHtml($c),$w) }
function Txt([string]$s,[float]$x,[float]$y,[float]$size,[string]$c=$script:ink,[bool]$bold=$false,[string]$face='Segoe UI') {
 $st=[System.Drawing.FontStyle]::Regular; if($bold){$st=[System.Drawing.FontStyle]::Bold}; $f=[System.Drawing.Font]::new($face,$size,$st,[System.Drawing.GraphicsUnit]::Pixel); $b=Brush $c; $g.DrawString($s,$f,$b,$x,$y); $f.Dispose(); $b.Dispose()
}
function Line([float]$x1,[float]$y1,[float]$x2,[float]$y2,[string]$c=$script:rule,[float]$w=1){$p=Pen $c $w;$g.DrawLine($p,$x1,$y1,$x2,$y2);$p.Dispose()}
function Rect([float]$x,[float]$y,[float]$w,[float]$h,[string]$c){$b=Brush $c;$g.FillRectangle($b,$x,$y,$w,$h);$b.Dispose()}
function Dot([float]$x,[float]$y,[float]$r,[string]$c){$b=Brush $c;$g.FillEllipse($b,$x-$r,$y-$r,2*$r,2*$r);$b.Dispose()}
function Card([float]$x,[float]$y,[float]$w,[float]$h,[string]$tag,[string]$title,[string[]]$lines,[string]$accent=$script:red){
 Rect $x $y $w $h $script:paper; Rect $x $y 5 $h $accent; Txt $tag.ToUpper() ($x+18) ($y+13) 12 $accent $true
 Txt $title ($x+18) ($y+34) 22 $script:ink $true
 for($i=0;$i -lt $lines.Count;$i++){Txt $lines[$i] ($x+18) ($y+64+($i*20)) 15 $script:muted}
}
# masthead
Txt 'ONE DAY · WORLD NEWS' 48 27 13 $red $true
Txt 'THURSDAY EDITION · LIVE' 766 25 13 $ink $true
Line 48 52 976 52 $ink 2
Txt 'Thursday, 19 November 2026' 48 64 39 $ink $true 'Georgia'
Txt 'Diplomacy · security · justice · health · markets' 51 112 17 $muted
Txt 'SNAPSHOT · 14:00 UTC' 793 116 11 $muted $true
# lead stories
Card 48 151 452 215 'Asia · APEC' 'Three leaders, one summit' @('Trump, Xi and Putin joined APEC leaders for a','group photo; their trilateral talks are still ahead.','Trump says arms control and wars are on his agenda.') $blue
# original summit illustration: three chair/table marks
Line 82 318 466 318 '#D9D1C5' 2
foreach($p in @(@{x=162;c='#B44635'},@{x=275;c='#C08A35'},@{x=388;c='#345B78'})){Dot ($p.x) 291 17 $p.c;Rect ($p.x-19) 310 38 28 $p.c;Line ($p.x-28) 341 ($p.x+28) 341 $script:ink 3}
Line 132 353 418 353 $script:ink 4
Card 524 151 452 215 'Europe · War' 'Crimean Bridge hit again' @('Traffic stopped after a reported third attack','in a week, a Russian-appointed official said.','Damage assessment was under way.') $red
# original bridge icon
Line 556 320 944 320 '#B7C3C7' 4; Line 556 287 944 287 $script:ink 5; Line 591 287 591 320 $script:ink 3; Line 901 287 901 320 $script:ink 3
$arc=Pen $script:blue 3;$g.DrawArc($arc,630,275,232,88,180,180);$arc.Dispose();Dot 742 274 5 $script:red
# secondary cards
Card 48 386 292 150 'Asia · APEC' 'Xi pledges $20m' @('Funding for APEC cooperation;','also proposes a Shenzhen','research centre.') $gold
Card 366 386 292 150 'Berlin · Ukraine' 'Talks due in Berlin' @('US envoys are due to join','Ukraine and European officials;','no deal reported at 14:00 UTC.') $teal
Card 684 386 292 150 'The Hague · Law' 'ICJ Rohingya ruling due' @('Gambia v. Myanmar judgment','scheduled today; outcome not','yet in this 14:00 UTC edition.') $red
# section title
Line 48 558 976 558 $ink 2
Txt 'MORE FROM THE DAY' 48 572 19 $red $true
Txt 'FACTS ATTRIBUTED · DEVELOPING ITEMS LABELLED' 610 579 11 $muted $true
# schematic original world map: a compact, original location strip
Rect 48 610 928 66 '#E9E5DB'
Txt 'DATELINES' 63 622 12 $blue $true
# simple original equirectangular map with abstract continental silhouettes and datelines
$land=Brush '#D4CCBA'
$g.FillPolygon($land,[System.Drawing.Point[]]@([System.Drawing.Point]::new(165,628),[System.Drawing.Point]::new(210,622),[System.Drawing.Point]::new(238,632),[System.Drawing.Point]::new(255,644),[System.Drawing.Point]::new(236,653),[System.Drawing.Point]::new(226,665),[System.Drawing.Point]::new(201,662),[System.Drawing.Point]::new(185,650)))
$g.FillPolygon($land,[System.Drawing.Point[]]@([System.Drawing.Point]::new(270,651),[System.Drawing.Point]::new(289,655),[System.Drawing.Point]::new(300,668),[System.Drawing.Point]::new(292,677),[System.Drawing.Point]::new(280,667)))
$g.FillPolygon($land,[System.Drawing.Point[]]@([System.Drawing.Point]::new(427,630),[System.Drawing.Point]::new(457,622),[System.Drawing.Point]::new(485,627),[System.Drawing.Point]::new(496,636),[System.Drawing.Point]::new(480,646),[System.Drawing.Point]::new(462,643),[System.Drawing.Point]::new(447,652),[System.Drawing.Point]::new(433,644)))
$g.FillPolygon($land,[System.Drawing.Point[]]@([System.Drawing.Point]::new(465,650),[System.Drawing.Point]::new(483,649),[System.Drawing.Point]::new(489,662),[System.Drawing.Point]::new(480,677),[System.Drawing.Point]::new(474,668)))
$g.FillPolygon($land,[System.Drawing.Point[]]@([System.Drawing.Point]::new(492,628),[System.Drawing.Point]::new(550,622),[System.Drawing.Point]::new(600,627),[System.Drawing.Point]::new(641,620),[System.Drawing.Point]::new(701,625),[System.Drawing.Point]::new(755,632),[System.Drawing.Point]::new(763,643),[System.Drawing.Point]::new(729,648),[System.Drawing.Point]::new(693,645),[System.Drawing.Point]::new(666,654),[System.Drawing.Point]::new(623,648),[System.Drawing.Point]::new(594,656),[System.Drawing.Point]::new(562,647),[System.Drawing.Point]::new(524,650),[System.Drawing.Point]::new(501,641)))
$g.FillPolygon($land,[System.Drawing.Point[]]@([System.Drawing.Point]::new(561,650),[System.Drawing.Point]::new(585,652),[System.Drawing.Point]::new(581,670),[System.Drawing.Point]::new(569,676),[System.Drawing.Point]::new(558,662)))
$g.FillPolygon($land,[System.Drawing.Point[]]@([System.Drawing.Point]::new(699,660),[System.Drawing.Point]::new(734,657),[System.Drawing.Point]::new(746,664),[System.Drawing.Point]::new(730,670),[System.Drawing.Point]::new(708,668)))
$land.Dispose()
# dots placed by approximate longitude and latitude
Dot 456 635 5 $red; Txt 'Berlin' 464 622 10 $ink
Dot 471 637 5 $red; Txt 'Crimea' 479 640 10 $ink
Dot 583 643 5 $gold; Txt 'Shenzhen' 591 630 10 $ink
Dot 555 649 5 $teal; Txt 'Hormuz' 535 658 10 $ink
Dot 737 665 5 $blue; Txt 'Wellington' 745 655 10 $ink
Dot 485 663 5 $red; Txt 'East Africa' 492 666 10 $ink
Txt 'World datelines · schematic map' 63 648 11 $muted $true
# short news list: 21 verified updates in three columns
Line 48 690 976 690 $ink 2
Txt 'ALSO REPORTED TODAY' 48 698 17 $red $true
Txt 'ATTRIBUTED · SHORT BRIEFS' 770 704 10 $muted $true
$items=@(
 @('GLOBAL · ECONOMY','IMF sees inflation reaching 4.7%.'),
 @('OCEANIA · LAW','NZ court: pay-equity rollback breached rights.'),
 @('AFRICA · FOOD','Kenya drought squeezes milk supply.'),
 @('MIDDLE EAST · WEST BANK','8 hurt in Kafr Qasim, MEE reports.'),
 @('MIDDLE EAST · YEMEN','Coalition says it hit missile platform.'),
 @('MIDDLE EAST · SHIPPING','UKMTO: tanker struck off Oman.'),
 @('ASIA · DIPLOMACY','Putin calls Russia part of Asia-Pacific.'),
 @('MIDDLE EAST · SECURITY','Coalition reports Houthi missile threat.'),
 @('N. AMERICA · HEALTH','Pennsylvania reports 8th measles death.'),
 @('UK · MARITIME','Bayesian inquiry flags missed wind risk.'),
 @('OCEANIA · TECHNOLOGY','Tasmania rejects data-centre moratorium.'),
 @('OCEANIA · JUSTICE','NSW coroner: 2022 custody death preventable.'),
 @('ASIA · CRICKET','India takes 4 NZ wickets on Test day one.'),
 @('MIDDLE EAST · GAZA','Israeli military begins central Gaza operation.'),
 @('ASIA · LAW','ICJ Rohingya judgment scheduled today.'),
 @('US · EQUITIES','Wed close: Dow fell 1.1%; Nasdaq rose 0.4%.'),
 @('US · PREMARKET','Futures edge up before Anthropic debut.'),
 @('US · TREASURIES','Wed close: 10Y yield down 4bp to 5.07%.'),
 @('GOLD · FUTURES','Wed settle: gold fell 3.16% to $3,741.90/oz.'),
 @('CRYPTO · BITCOIN','Wed close: BTC $62,709, down 3.35%.'),
 @('MIDDLE EAST · IRAN','Axios: Trump still weighs joint strikes.'),
 @('US · FED · GOOLSBEE','Q&A scheduled for 11:30 am CT.'),
 @('US · FED · BARR','Community-development speech at 1:35 ET.'),
 @('US · FED · BARR','AI discussion scheduled for 2:15 pm ET.'),
 @('ASIA · APEC','Xi urges open trade, tech development.'),
 @('EUROPE · BANKING','UniCredit and Germany agree key points.'),
 @('US · RELIGION / TECH','Bishops launch AI task force; urge safeguards.')
)
$cols=@(48,282,516,750);$rows=7
for($i=0;$i -lt $items.Count;$i++){$col=[math]::Floor($i/$rows);$row=$i%$rows;$x=$cols[$col];$y=728+$row*22;Txt $items[$i][0] $x $y 8.3 $blue $true;Txt $items[$i][1] $x ($y+9) 10 $ink;Line $x ($y+20) ($x+218) ($y+20) '#DCD5C9' 1}
# Footer transparency
Line 48 888 976 888 $ink 2
Txt 'DATE CHECK' 48 899 12 $red $true
Txt 'Nov 18 events screened out; future outcomes remain unconfirmed in this snapshot.' 134 897 13 $muted
Txt 'Sources: AP · Reuters · HLB · Faircurve · Axios · Al Jazeera · Chicago Fed · Fed Board · ICJ · BBC · NZME · MEE · UK MAIB · ABC.' 48 923 10.5 $muted
Txt 'Original illustration · News day still in progress · 19 Nov 2026, 14:00 UTC.' 48 948 12 $muted
$path=Join-Path $PSScriptRoot 'entry.png';$bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose();$bmp.Dispose()



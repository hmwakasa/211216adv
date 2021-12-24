\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{waku}[2021/12/23]

\newif\ifgrid\gridfalse
\DeclareOption{grid}{\gridtrue}
\ProcessOptions\relax

\LoadClass[
	jafontsize=2.5mm,
	baselineskip=1.1zh,
	line_length=63mm,
	paper={63mm,88mm},
	gutter=0pt,
	head_space=0pt,
	foot_space=0pt,
	fore-edge=0pt,
]{jlreq}
\RequirePackage{luatexja,xparse,xcolor,graphicx,luatexja-fontspec}
\RequirePackage{tikz}
\RequirePackage[export]{adjustbox}
\usetikzlibrary{calc}
\RequirePackage[pdfbox]{gentombow}
\settombowbleed{3mm}
\setlength{\parindent}{0pt}

\NewDocumentCommand\Card{m m m}{%
	\begin{tikzpicture}[x=1mm,y=1mm]
		\coordinate(OL1)at(0,0);\coordinate(OL3)at(63,88);
		\coordinate(OO1)at(-3,-3);\coordinate(OO3)at(66,91);
		\coordinate(N3)at(3,75);\coordinate(N1)at(66,85);
		\coordinate(A3)at(5,40);\coordinate(A1)at(58,75);
		\coordinate(T3)at(5,3);\coordinate(T1)at(58,40);
		\useasboundingbox(OL1)rectangle(OL3);
		%% 枠
		\fill[black](OO1)rectangle(OO3);
		\fill[white](A3)rectangle(A1);
		\fill[white](T3)rectangle(T1);
		\filldraw[fill=white](N3)rectangle(N1);
		%% 絵
		%%%% min size オプションは adjustbox パッケージが提供。
		%%%% 枠内いっぱいに縦横比維持して表示するためのトリック。
		%%%% （min size を指定しないと、枠内に余白ができる）
		\draw[path picture={\node at (path picture bounding box.center)
			{\includegraphics[width=53mm,height=35mm,keepaspectratio,min size={53mm}{35mm},clip]
			{#2}};}](A1)-|(A3)-|cycle;
		%% 文字 （VisualTikz 17.8, 17.9 あたりを参照）
		\path(N3)[anchor=south west,font=\fontsize{6mm}{0pt}\selectfont]node{#1};
		\path(T1)--(T3)node[midway,anchor=center,text width=50mm,align=flush center]{#3};
		%% 方眼
		\ifgrid
			\draw[very thin,cyan,nearly transparent]($(OL1)-(3,3)$)grid[step=1]($(OL3)+(3,3)$);
			\draw[thin,cyan,nearly transparent](OL1)grid[step=10](OL3);
			\draw[thin,cyan,nearly transparent](OL1)rectangle(OL3);
			\endif
		\fi
	\end{tikzpicture}%
}


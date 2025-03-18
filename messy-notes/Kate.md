## Kate Editor

#### Vim mode

- `~/.config/katevirc`:
```
...
Insert Mode Mapping Keys=w;,;w,жц,цж
Insert Mode Mappings=<esc>,<esc>,<esc>,<esc>
Insert Mode Mappings Recursion=false,false,false,false

...
Normal Mode Mapping Keys=№,Ё,А,Б,В,Г,Д,Е,Ж,З,И,Й,К,Л,М,Н,О,П,Р,С,Т,У,Ф,Х,Ц,Ч,Ш,Щ,Ъ,Ы,Ь,Э,Ю,Я,а,б,в,г,д,е,ж,з,и,й,",к,л,м,н,о,п,р,с,т,у,\\,,ф,х,.,ц,ч,/,ш,щ,ъ,ы,ь,э,ю,я,ё,:,;,?
Normal Mode Mappings=#,~,F,<,D,U,L,T,:,P,B,Q,R,K,V,Y,J,G,H,C,N,E,A,{,W,X,I,O,},S,M,",>,Z,f,\\,,d,u,l,t,;,p,b,q,@,r,k,v,y,j,g,h,c,n,e,?,a,[,/,w,x,|,i,o,],s,m,',.,z,`,^,$,&
Normal Mode Mappings Recursion=false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false
```

- Okular editor command: `kate --line %l --column %c`

- Okular call (?): `okular --unique 'file.pdf#src:linenumber file.tex'`

#### Misc

- Ж must be non-recursive?


- Custom shortcuts:
```
Build Default Target: Ctrl+F5
Show Build Output:    Ctrl+F6
Show Projects:        Ctrl+F8
Show Current Project: Ctrl+Shift+F6
```
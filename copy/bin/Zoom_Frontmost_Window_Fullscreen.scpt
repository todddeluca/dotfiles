FasdUAS 1.101.10   ��   ��    k             l     ��  ��    N H http://jon.smajda.com/2007/06/30/keyboard-control-for-mac-os-x-windows/     � 	 	 �   h t t p : / / j o n . s m a j d a . c o m / 2 0 0 7 / 0 6 / 3 0 / k e y b o a r d - c o n t r o l - f o r - m a c - o s - x - w i n d o w s /   
  
 l     ��������  ��  ��        l     ��  ��      get size of display     �   (   g e t   s i z e   o f   d i s p l a y      l     ��  ��    R L see http://daringfireball.net/2006/12/display_size_applescript_the_lazy_way     �   �   s e e   h t t p : / / d a r i n g f i r e b a l l . n e t / 2 0 0 6 / 1 2 / d i s p l a y _ s i z e _ a p p l e s c r i p t _ t h e _ l a z y _ w a y      l     ��  ��    S M note: won't work with multiple monitors, so just remove & set manually, i.e.     �   �   n o t e :   w o n ' t   w o r k   w i t h   m u l t i p l e   m o n i t o r s ,   s o   j u s t   r e m o v e   &   s e t   m a n u a l l y ,   i . e .      l     ��  ��    $  		"set display_y_size to 756"     �   <   	 	 " s e t   d i s p l a y _ y _ s i z e   t o   7 5 6 "     !   l     �� " #��   " %  		"set display_x_size to 1280"    # � $ $ >   	 	 " s e t   d i s p l a y _ x _ s i z e   t o   1 2 8 0 " !  % & % l    " '���� ' O     " ( ) ( k    ! * *  + , + r     - . - n     / 0 / 1   	 ��
�� 
pbnd 0 n    	 1 2 1 m    	��
�� 
cwin 2 1    ��
�� 
desk . o      ���� 0 _b   ,  3 4 3 r     5 6 5 n     7 8 7 4    �� 9
�� 
cobj 9 m    ����  8 o    ���� 0 _b   6 o      ���� 0 display_x_size   4  : ; : r     < = < n     > ? > 4    �� @
�� 
cobj @ m    ����  ? o    ���� 0 _b   = o      ���� 0 display_y_size   ;  A�� A r    ! B C B l    D���� D \     E F E o    ���� 0 display_y_size   F m    ���� (��  ��   C o      ���� 0 display_y_size  ��   ) m      G G�                                                                                  MACS  alis    r  Macintosh HD               ���H+   Z�
Finder.app                                                      ��Ǵт        ����  	                CoreServices    ��      ǵ�     Z� ZD ZC  3Macintosh HD:System:Library:CoreServices:Finder.app    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  ��  ��   &  H I H l     ��������  ��  ��   I  J K J l  # , L���� L r   # , M N M l  # * O���� O I  # *�� P Q
�� .earsffdralis        afdr P m   # $��
�� appfegfp Q �� R��
�� 
rtyp R m   % &��
�� 
utxt��  ��  ��   N o      ���� 0 cur_app  ��  ��   K  S T S l  - R U���� U Z   - R V W�� X V D   - 0 Y Z Y o   - .���� 0 cur_app   Z m   . / [ [ � \ \  : F i n d e r . a p p : W k   3 J ] ]  ^ _ ^ r   3 8 ` a ` m   3 4��
�� boovtrue a o      ���� 0 finder Finder _  b�� b O   9 J c d c r   = I e f e n   = E g h g 1   A E��
�� 
tbvi h 4  = A�� i
�� 
cwin i m   ? @����  f o      ���� 0 tool_vis   d m   9 : j j�                                                                                  MACS  alis    r  Macintosh HD               ���H+   Z�
Finder.app                                                      ��Ǵт        ����  	                CoreServices    ��      ǵ�     Z� ZD ZC  3Macintosh HD:System:Library:CoreServices:Finder.app    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  ��  ��   X r   M R k l k m   M N��
�� boovfals l o      ���� 0 finder Finder��  ��   T  m n m l     ��������  ��  ��   n  o p o l  S � q���� q O   S � r s r O   \ � t u t k   c � v v  w x w r   c � y z y l  c g {���� { e   c g | | 1   c g��
�� 
pbnd��  ��   z J       } }  ~  ~ o      ���� 0 x1     � � � o      ���� 0 y1   �  � � � o      ���� 0 x2   �  ��� � o      ���� 0 y2  ��   x  � � � l  � ��� � ���   � # 		set win_height to (y2 - y1)    � � � � : 	 	 s e t   w i n _ h e i g h t   t o   ( y 2   -   y 1 ) �  � � � l  � ��� � ���   � " 		set win_width to (x2 - x1)    � � � � 8 	 	 s e t   w i n _ w i d t h   t o   ( x 2   -   x 1 ) �  � � � Z   � � � ��� � � o   � ����� 0 finder Finder � k   � � � �  � � � r   � � � � � m   � ����� + � o      ���� 0 y1   �  � � � r   � � � � � o   � ����� 0 display_y_size   � o      ���� 0 y2   �  � � � r   � � � � � o   � ����� 0 display_x_size   � o      ���� 0 x2   �  ��� � r   � � � � � m   � �����   � o      ���� 0 x1  ��  ��   � k   � � � �  � � � r   � � � � � m   � �����   � o      ���� 0 y1   �  � � � r   � � � � � o   � ����� 0 display_y_size   � o      ���� 0 y2   �  � � � r   � � � � � o   � ����� 0 display_x_size   � o      ���� 0 x2   �  ��� � r   � � � � � m   � �����   � o      ���� 0 x1  ��   �  ��� � r   � � � � � J   � � � �  � � � o   � ����� 0 x1   �  � � � o   � ����� 0 y1   �  � � � o   � ����� 0 x2   �  ��� � o   � ����� 0 y2  ��   � 1   � ���
�� 
pbnd��   u 4  \ `�� �
�� 
cwin � m   ^ _����  s 4   S Y�� �
�� 
capp � o   W X���� 0 cur_app  ��  ��   p  ��� � l     ��������  ��  ��  ��       �� � ���   � ��
�� .aevtoappnull  �   � **** � �� ����� � ���
�� .aevtoappnull  �   � **** � k     � � �  % � �  J � �  S � �  o����  ��  ��   �   �  G���������������������������� [����~�}�|�{�z�y�x
�� 
desk
�� 
cwin
�� 
pbnd�� 0 _b  
�� 
cobj�� 0 display_x_size  �� �� 0 display_y_size  �� (
�� appfegfp
�� 
rtyp
�� 
utxt
�� .earsffdralis        afdr�� 0 cur_app  �� 0 finder Finder
� 
tbvi�~ 0 tool_vis  
�} 
capp�| 0 x1  �{ 0 y1  �z 0 x2  �y 0 y2  �x +�� �� *�,�,�,E�O��m/E�O���/E�O��E�UO���l E�O�� eE` O� *�k/a ,E` UY fE` O*a �/ �*�k/ x*�,EE[�k/E` Z[�l/E` Z[�m/E` Z[��/E` ZO_  a E` O�E` O�E` OjE` Y jE` O�E` O�E` OjE` O_ _ _ _ �v*�,FUU ascr  ��ޭ
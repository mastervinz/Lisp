
(vl-load-com)
(setq *AcDoc* (vla-get-activeDocument (vlax-get-acad-object)))


;;;										
;;;				MKCOTSTYLE					
;;;										

(defun mkcotstyle (/ sc app xd1 xd2)
  (setq	sc  (vla-add (vla-get-dimstyles *acdoc*) ".Plan")
	app "AcadAnnotative"
	xd1 (vlax-make-safearray vlax-vbInteger '(0 . 5))
	xd2 (vlax-make-safearray vlax-vbVariant '(0 . 5))
  )
  (or descrunite
      (cond ((= unite "me") (setq descrunite '(1000 6 100 0.01)))
	    ((= unite "cm") (setq descrunite '(10 5 1 1)))
	    ((= unite "mm") (setq descrunite '(1 4 0.1 10)))
      )
  )
  (or (tblsearch "style" ".Verdana 1.5")
      (mkstyle (list ".Verdana 1.5" 1.5 "verdana.TTF")))
      
  (vla-put-activedimstyle *acdoc* sc)
  (regapp app)
  (vlax-safearray-fill
    xd1
    (list 1001 1000 1002 1070 1070 1002)
  )
  (vlax-safearray-fill
    xd2
    (list "AcadAnnotative"
	  "AnnotativeData"
	  "{"
	  (vlax-make-variant 1 vlax-vbInteger)
	  (vlax-make-variant 1 vlax-vbInteger)
	  "}"
    )
  )
  (vla-setxdata sc xd1 xd2)
  (vla-getxdata sc app 'rt1 'rt2)
  (mapcar (function (lambda (x y) (cons x y)))
	  (vlax-safearray->list rt1)
	  (mapcar 'vlax-variant-value (vlax-safearray->list rt2))
  )
  (setq lin (vla-get-linetypes *AcdoC*))
  (and (vl-catch-all-error-p
	 (vl-catch-all-apply 'vla-item (list lin "POINTILLE"))
       )
       (vla-load lin "POINTILLE" (findfile "acadiso.lin"))
  ); charge le type de ligne POINTILLE
  
  (setvar "DIMLTEX1" "POINTILLE")
  (setvar "DIMLTEX2" "POINTILLE")
  ;;D�finit les type de lignes d'attache.
  (setvar "DIMASSOC" 2)
  ;;Cr�e des objets de cotes associatifs
  (setvar "DIMASZ" 1)
  ;;D�finit la taille des pointes de fl�ches
  (setvar "DIMBLK" "MarqueArch")
  ;;D�finit les pointes de fl�che affich�es aux extr�mit�s des lignes de cote
  (setvar "DIMFXLON" 0)
  ;;D�finit si les lignes d'attache ont une longueur fixe
;;;  (setvar "DIMLDRBLK" "")
  ;;Sp�cifie le type de fl�che Ferm�e-Pleine pour les lignes de rep�re
  (setvar "DIMLFAC" (caddr descrunite))
  ;;D�finit un facteur d'�chelle pour les cotes lin�aires
  (setvar "DIMLTYPE" "DUBLOC")
  ;;Type de ligne de la ligne de c�te
  (setvar "DIMLWD" 13)
  ;;Attribue une �paisseur aux lignes de cote
  (setvar "DIMLWE" 13)
  ;;Attribue une �paisseur aux lignes d'attache
  (setvar "DIMTFILL" 0)
  ;;D�termine l'arri�re-plan du texte de cote - Aucun arri�re-plan
  (setvar "DIMTXSTY" ".Verdana 1.5")
  ;;Indique le style de texte de la cote
  (setvar "DIMUPT" 0)
  ;;Le curseur g�re uniquement l'emplacement de la ligne de cote
  (setvar "LUNITS" 2)
  ;;D�finit des unit�s lin�aires d�cimales
  (setvar "DIMDEC" 0)
  ;;D�finit des unit�s lin�aires d�cimales
  (setvar "DIMTAD" 3)
  ;;Place le texte de la c�te sur la ligne de c�te
  (setvar "DIMTIH" 0)
  ;;Aligne le texte � la ligne de c�te
  (setvar "DIMGAP" 0.65)
  ;;Aligne le texte � la ligne de c�te
  (setvar "DIMTMOVE" 1)
  ;;Ajuste le mouvement du texte
  (setvar "DIMTOH" 0)
  ;;Alignement ext�rieur du texte
  (setvar "DIMRND" 0.5)
  ;;Arrondi
  (setvar "DIMTOFL" 1)
  ;Tracer 
  

  (vla-copyfrom sc *acdoc*)

)



;;;										
;;;	MCUR (routine passe courant un calque cr�� si inexistant)		
;;;										

(defun MCUR (layname laycol /)
  (if (not (tblsearch "LAYER" layname))
    (entmake (append
	       '((0 . "LAYER")
		 (100 . "AcDbSymbolTableRecord")
		 (100 . "AcDbLayerTableRecord")
		 (70 . 0)
		 (370 . -3)
		 (6 . "Continuous")
		)
	       (list (cons 62 laycol))
	       (list (cons 2 layname))
	     )
    )
  )
  (setvar "clayer" layname)
  (setvar "cecolor" "DuCalque")
)
;;;*****************************************************************************
;;;*****************************************************************************
;;;************	        	CONFIGUE AUTOCAD FABIEN 	****************
;;;*****************************************************************************
;;;*****************************************************************************


;;;										
;;;			R�glage perso    					
;;;										

(defun c:fr (/)

;;;										
;;;			VARIABLES NON ENREGISTREES				
;;;										

  (setvar "HPDRAWORDER" 1)
  ;;place les hachures en arri�re plan
  (setvar "OSNAPZ" 1)
  ;;Accrobj substitue la valeur Z du point sp�cifi� par l'�l�vation courante
  (setvar "modemacro" "Config FR")
  ;;Affiche une cha�ne de caract�res sur la ligne d'�tat


;;;										
;;;		VARIABLES ENREGISTREES DANS LE REGISTRE				
;;;										


  ;; GESTION DU ALT TAB  
  (setvar "EDGEMODE" 0)
  ;; PAS d'Intersection projet�es pour les commandes ajuster et prolonger
  (setvar "FIELDDISPLAY" 0)
  ;; Masque l'arri�re plan des champs
  (setvar "DYNPICOORDS" 0)
  ;; Coordonn�es relatives pour la saisie du second point
  (setvar "PROXYSHOW" 0)
  ;; N'affiche pas les graphiques externes
  (setvar "PROXYNOTICE" 0)
  ;; Aucun avertissement concernant les objets externes n'est affich�.
  (setvar "XREFTYPE" 1)
  ;; Les Xref sont superpos�es (pour �viter les imbrications en cha�ne)
  (setvar "ANNOAUTOSCALE" -1)
  ;; n'ajoute pas l'�chelle aux objets gel�s, v�rouill�s ou desactiv�s
  (setvar "HPMAXLINES" 10000000)
  ;; G�re le nombre maximum de lignes de hachures qui seront g�n�r�es
  (setvar "HPSEPARATE" 1)
  ;; Des objets de hachures distincts sont cr��s
  (setvar "osmode" 6655)
  ;; D�finit les accrochages aux objets actifs
  (setvar "OSNAPNODELEGACY" 0)
  ;; L'accrochage aux objets Noeud des texte multiligne.
  (setvar "LAYERFILTERALERT" 3)
  ;;Lorsque le dessin est ouvert, affiche un message indiquant le probl�me et
  ;;Affiche une bo�te de dialogue pour s�lectionner les filtres � supprimer
  (setvar "PAPERUPDATE" 1)
  ;;D�finit le format de papier en fonction de la valeur sp�cifi�e
  ;;dans le fichier de configuration du traceur
  (setvar "PEDITACCEPT" 1)
  ;;L'invite est supprim�e, l'objet s�lectionn� est automatiquement converti en polyligne
  (setvar "RECOVERYMODE" 1)
  ;;La fen�tre de r�cup�ration ne s'affiche pas apr�s un plantage.
  (setvar "LAYLOCKFADECTL" 50)
  ;;G�re l'att�nuation des objets sur les calques verrouill�s
  (setvar "PICKADD" 2)
					;choix du mode de s�lection
  (setvar "PICKBOX" 4)
  ;;D�finit, en pixels, la hauteur de la cible de s�lection d'objets.
  (setvar "PUBLISHALLSHEETS" 0)
  ;;Seul le contenu du document courant
  (setvar "LWUNITS" 1)
  ;;unit� mm pour les �paisseurs de polyligne


;;;										
;;;		  PASSE LE CALQUE 0 EN ROUGE (TRUECOLOR)			
;;;										

  (setq lstlay0 (entget (tblobjname "layer" "0")))
  (if (assoc 420 lstlay0)
    (entmod
      (subst (cons 420 16711680) (assoc 420 lstlay0) lstlay0)
    )
    (entmod (append lstlay0 (list (cons 420 16711680))))
  )

)					;defun FR


(c:fr)

;;;										
;;;				CHARGEMENT DES LISP				
;;;										



(load "0_General")
(load "2_CVC")
(load "2_DES")


;;;				C:LI	C:LO	C:LP				
;;;										
;;;				Commandes de cotation				
;;;										

(defun c:li (/ *error*)

  (defun *error* (msg)
    (if	(= msg "Fonction annul�e")
      (progn
	(princ (strcat "\nErreur: " msg))
	(setvar "clayer" clayer)
	(vla-endundomark *acdoc*)
	(princ)
      )
    )
  )


  (vla-StartUndoMark *AcDoc*)
  (setq	clayer	(getvar "clayer")
	cecolor	(getvar "cecolor")
  )
  (MCUR	(strcat	"0 "
		entreprise
		" "
		(nth 2 (gc:str2lst clayer " "))
		" PRO P - Cotation G"
	)
	253
  )
  (command "_dimlinear" pause pause pause)
  (setvar "clayer" clayer)
  (setvar "cecolor" cecolor)
  (vla-EndUndoMark *AcDoc*)
)


(defun c:lo (/ *error*)

  (defun *error* (msg)
    (if	(= msg "Fonction annul�e")
      (progn
	(princ (strcat "\nErreur: " msg))
	(setvar "clayer" clayer)
	(vla-endundomark *acdoc*)
	(command "_undo")
	(princ)
      )
    )
  )

  (setq	clayer	(getvar "clayer")
	cecolor	(getvar "cecolor")
  )
  (MCUR	(strcat	"0 "
		entreprise
		" "
		(nth 2 (gc:str2lst clayer " "))
		" PRO P - Cotation G"
	)
	253
  )
  (command "_dimaligned" pause pause pause)
  (setvar "clayer" clayer)
  (setvar "cecolor" cecolor)
  (vla-EndUndoMark *AcDoc*)
)


(defun c:lp (/ *error*)

  (defun *error* (msg)
    (if	(= msg "Fonction annul�e")
      (progn
	(princ (strcat "\nErreur: " msg))
	(setvar "clayer" clayer)
	(vla-endundomark *acdoc*)
	(princ)
      )
    )
  )

  (vla-StartUndoMark *AcDoc*)
  (setq	clayer	(getvar "clayer")
	cecolor	(getvar "cecolor")
  )
  (MCUR	(strcat	"0 "
		entreprise
		" "
		(nth 2 (gc:str2lst clayer " "))
		" PRO P - Cotation G"
	)
	253
  )
  (command "_dimcontinue"
	   (while (not (zerop (getvar "cmdactive")))
	     (command pause)
	   )
  )
  (setvar "clayer" clayer)
  (setvar "cecolor" cecolor)
  (vla-EndUndoMark *AcDoc*)
)



;;;										
;;;				CREATION D'ALIAS				
;;;										

(defun c:pgp () (command "ai_editcustfile" "acad.pgp"))

(defun c:cr () (command "corresprop"))

(defun c:ql () (command "qleader"))

(defun c:cl () (command "laymcur"))

(defun c:f () (command "_-vports"))

(defun c:pc () (command "publishcollate"))

(defun c:nr () (command "nuagerev"))

(defun c:di () (command "dist"))

(defun c:ca () (command "CALCRAPIDE"))

(defun c:dv () (command "decaler" "e" "o"))

(defun c:dc () (command "decaler" "e" "n"))

(defun c:f1 () (command "_vscurrent" "2"))
(defun c:f2 () (command "_vscurrent" "c"))

(defun c:hi () (command "_isolateobjects"))
(defun c:hr () (command "_unisolateobjects"))
(defun c:hh () (command "_hideobjects"))

(defun c:v5 ()
  (command "-vue" "g" "h")
  (c:f1)
  (setq	layHaut	  "0 Xref 2D Haut"
	layDroite "0 Xref 2D Droite"
	layFace	  "0 Xref 2D Face"
  )
  (if (tblsearch "LAYER" layHaut)
    (vla-put-freeze (vla-item *layers* layHaut) :vlax-false)
  )
  (if (tblsearch "LAYER" layDroite)
    (vla-put-freeze (vla-item *layers* layDroite) :vlax-True)
  )
  (if (tblsearch "LAYER" layFace)
    (vla-put-freeze (vla-item *layers* layFace) :vlax-True)
  )
  (vla-regen *acdoc* acActiveViewport )
)
(defun c:v6 ()
  (command "-vue" "g" "d")
  (c:f1)
  (setq	layHaut	  "0 Xref 2D Haut"
	layDroite "0 Xref 2D Droite"
	layFace	  "0 Xref 2D Face"
  )
  (if (tblsearch "LAYER" layHaut)
    (vla-put-freeze (vla-item *layers* layHaut) :vlax-True)
  )
  (if (tblsearch "LAYER" layDroite)
    (vla-put-freeze (vla-item *layers* layDroite) :vlax-false)
  )
  (if (tblsearch "LAYER" layFace)
    (vla-put-freeze (vla-item *layers* layFace) :vlax-True)
  )
  (vla-regen *acdoc* acActiveViewport )
)
(defun c:v2 ()
  (command "-vue" "g" "a")
  (c:f1)
  (setq	layHaut	  "0 Xref 2D Haut"
	layDroite "0 Xref 2D Droite"
	layFace	  "0 Xref 2D Face"
  )
  (if (tblsearch "LAYER" layHaut)
    (vla-put-freeze (vla-item *layers* layHaut) :vlax-True)
  )
  (if (tblsearch "LAYER" layDroite)
    (vla-put-freeze (vla-item *layers* layDroite) :vlax-True)
  )
  (if (tblsearch "LAYER" layFace)
    (vla-put-freeze (vla-item *layers* layFace) :vlax-false)
  )
  (vla-regen *acdoc* acActiveViewport )
)
(defun c:v3 ()
  (command "-vue" "_swiso")
  (c:f2)
  (setq	layHaut	  "0 Xref 2D Haut"
	layDroite "0 Xref 2D Droite"
	layFace	  "0 Xref 2D Face"
  )
  (if (tblsearch "LAYER" layHaut)
    (vla-put-freeze (vla-item *layers* layHaut) :vlax-True)
  )
  (if (tblsearch "LAYER" layDroite)
    (vla-put-freeze (vla-item *layers* layDroite) :vlax-True)
  )
  (if (tblsearch "LAYER" layFace)
    (vla-put-freeze (vla-item *layers* layFace) :vlax-True)
  )
  (vla-regen *acdoc* acActiveViewport )
)




















































































































































































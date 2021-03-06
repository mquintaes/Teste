$PBExportHeader$w_sel_pessoa.srw
$PBExportComments$Seleção de pessoa
forward
global type w_sel_pessoa from window
end type
type cb_ok2 from commandbutton within w_sel_pessoa
end type
type cb_cancela2 from commandbutton within w_sel_pessoa
end type
type cb_cancela from commandbutton within w_sel_pessoa
end type
type cb_ok from commandbutton within w_sel_pessoa
end type
type d_sel_pessoa from datawindow within w_sel_pessoa
end type
end forward

global type w_sel_pessoa from window
integer width = 2830
integer height = 1064
boolean titlebar = true
string title = "Selecione uma pessoa"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_ok2 cb_ok2
cb_cancela2 cb_cancela2
cb_cancela cb_cancela
cb_ok cb_ok
d_sel_pessoa d_sel_pessoa
end type
global w_sel_pessoa w_sel_pessoa

type variables
long il_MatriculaSelecionada
str_EmpregadoSelecionado istr_EmpregadoSelecionado
end variables
event open;d_Sel_Pessoa.setTransObject (sqlca)

d_Sel_Pessoa.retrieve()


end event

on w_sel_pessoa.create
this.cb_ok2=create cb_ok2
this.cb_cancela2=create cb_cancela2
this.cb_cancela=create cb_cancela
this.cb_ok=create cb_ok
this.d_sel_pessoa=create d_sel_pessoa
this.Control[]={this.cb_ok2,&
this.cb_cancela2,&
this.cb_cancela,&
this.cb_ok,&
this.d_sel_pessoa}
end on

on w_sel_pessoa.destroy
destroy(this.cb_ok2)
destroy(this.cb_cancela2)
destroy(this.cb_cancela)
destroy(this.cb_ok)
destroy(this.d_sel_pessoa)
end on

type cb_ok2 from commandbutton within w_sel_pessoa
integer x = 2478
integer y = 388
integer width = 265
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ok"
boolean default = true
end type

event clicked;closeWithReturn (w_sel_pessoa, il_MatriculaSelecionada)


end event

type cb_cancela2 from commandbutton within w_sel_pessoa
integer x = 2478
integer y = 524
integer width = 265
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancela"
boolean cancel = true
end type

event clicked;closeWithReturn (w_sel_pessoa, -1)

end event

type cb_cancela from commandbutton within w_sel_pessoa
integer x = 2478
integer y = 196
integer width = 265
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancela"
boolean cancel = true
end type

event clicked;//closeWithReturn (w_sel_pessoa, -1)

istr_EmpregadoSelecionado.usuarioCancelou = true

closeWithReturn (w_sel_pessoa, istr_EmpregadoSelecionado)
end event

type cb_ok from commandbutton within w_sel_pessoa
integer x = 2478
integer y = 60
integer width = 265
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ok"
boolean default = true
end type

event clicked;//closeWithReturn (w_sel_pessoa, il_MatriculaSelecionada)

istr_EmpregadoSelecionado.usuarioCancelou = false
closeWithReturn (w_sel_pessoa, istr_EmpregadoSelecionado)

end event

type d_sel_pessoa from datawindow within w_sel_pessoa
integer x = 9
integer y = 8
integer width = 2418
integer height = 908
integer taborder = 10
string title = "none"
string dataobject = "d_sel_pessoa"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_ColunaClicada

ls_ColunaClicada = dwo.name

if (row = 0) then
	return
end if


il_MatriculaSelecionada = d_Sel_Pessoa.getItemNumber (row, 'codigo')


istr_EmpregadoSelecionado.matricula = d_Sel_Pessoa.getItemNumber (row, 'codigo')
istr_EmpregadoSelecionado.nomeEmpregado = d_Sel_Pessoa.getItemString (row, 'primeironome')
istr_EmpregadoSelecionado.ultimoNome = d_Sel_Pessoa.getItemString (row, 'ultimonome')


return




end event

event doubleclicked;string ls_ColunaClicada
string ls_ColunaOrdenacao

ls_ColunaClicada = dwo.name

if (row <> 0) then
	return
end if

choose case ls_ColunaClicada
	case 'codigo_t'
//		ls_ColunaOrdenacao = 'codigo'
	case 'primeironome_t'
//		ls_ColunaOrdenacao = 'primeironome'
	case 'nomemeio_t'
//		ls_ColunaOrdenacao = 'nomemeio'
	case 'ultimonome_t'
//		ls_ColunaOrdenacao = 'ultimonome'
	case 'sufixo_t'
//		ls_ColunaOrdenacao = 'sufixo'
	case else		// se nunhum critério foi atendido
		return
end choose


// pega os primeiros caracteres da coluna tirando os dois últimos
ls_ColunaOrdenacao = left (ls_ColunaClicada, len (ls_ColunaClicada) - 2)

/*
ls_Ordenacao = left ('ultimonome_t', len ('ultimonome_t') - 2)
ls_Ordenacao = left ('ultimonome_t', 12 - 2)
ls_Ordenacao = left ('ultimonome_t', 10)
'ultimonome'
*/


//ls_Ordenacao = ls_ColunaOrdenacao

// configura o critério de ordenação
setSort (ls_ColunaOrdenacao)

// executa ordenação
sort()

return




end event


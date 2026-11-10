<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.agenda.model.JavaBeans"%>
<%@ page import="java.util.ArrayList"%>
<%
    String updatedParam = request.getParameter("updated");
    boolean contatoAtualizado = "1".equals(updatedParam);
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Agenda de contatos</title>
    <link rel="icon" href="imagens/fone.png" type="image/x-icon">
    
    <style>
        /* --- Reset e Estilos Globais --- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f4f6f9;
            color: #333333;
            display: flex;
            justify-content: center;
            padding: 40px 20px;
        }

        /* --- Container Principal --- */
        .container {
            width: 100%;
            max-width: 800px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        /* --- Título da Agenda --- */
        .titulo {
            font-size: 2rem;
            color: #1a202c;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #edf2f7;
        }

        /* --- Botão Novo Contato --- */
        .btn-novo {
            display: inline-block;
            background-color: #2b6cb0;
            color: #ffffff;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.95rem;
            margin-bottom: 25px;
            transition: background-color 0.2s ease, transform 0.1s ease;
        }

        .btn-novo:hover {
            background-color: #2c5282;
        }

        .btn-novo:active {
            transform: scale(0.98);
        }

        /* --- Tabela de Contatos --- */
        .tabela-contatos {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .tabela-contatos th, 
        .tabela-contatos td {
            padding: 12px 15px;
            text-align: left;
            vertical-align: middle;
        }

        .tabela-contatos th {
            background-color: #f7fafc;
            color: #4a5568;
            font-weight: 600;
            border-bottom: 2px solid #e2e8f0;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .tabela-contatos tr {
            border-bottom: 1px solid #edf2f7;
            transition: background-color 0.2s ease;
        }

        .tabela-contatos tr:hover {
            background-color: #f8fafc;
        }

        .tabela-contatos td {
            color: #4a5568;
            font-size: 0.95rem;
        }

        /* --- Botões de Ação de Linha --- */
        .btn-sm {
            display: inline-block;
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-right: 5px;
            transition: background-color 0.2s ease;
        }

        .btn-primary {
            background-color: #3182ce;
            color: white;
        }

        .btn-primary:hover {
            background-color: #2b6cb0;
        }

        .btn-danger {
            background-color: #e53e3e;
            color: white;
        }

        .btn-danger:hover {
            background-color: #c53030;
        }
        
        .acoes-col {
            text-align: right;
            width: 180px;
        }

        /* --- Toast de feedback --- */
        .toast-feedback {
            position: fixed;
            top: 24px;
            left: 50%;
            display: flex;
            align-items: center;
            gap: 10px;
            background-color: #276749;
            color: #ffffff;
            padding: 12px 18px;
            border-radius: 8px;
            font-size: 0.95rem;
            font-weight: 600;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            opacity: 0;
            transform: translate(-50%, -12px);
            pointer-events: none;
            z-index: 1000;
            transition: opacity 0.25s ease, transform 0.25s ease;
        }

        .toast-feedback.show {
            opacity: 1;
            transform: translate(-50%, 0);
        }

        .toast-feedback.hide {
            opacity: 0;
            transform: translate(-50%, -12px);
        }

        .toast-feedback svg {
            flex-shrink: 0;
        }

        @media (max-width: 480px) {
            .toast-feedback {
                width: calc(100% - 32px);
                justify-content: center;
                text-align: center;
            }
        }
    </style>
</head>
<body>

    <% if (contatoAtualizado) { %>
        <div id="toastAtualizado" class="toast-feedback show" role="status" aria-live="polite">
            <svg width="20" height="20" viewBox="0 0 20 20" fill="none" aria-hidden="true">
                <circle cx="10" cy="10" r="9" fill="rgba(255,255,255,0.18)"/>
                <path d="M6.5 10.5l2.4 2.4L13.8 8" stroke="#ffffff" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <span>Contato atualizado com sucesso</span>
        </div>
    <% } %>

    <div class="container">
        <h1 class="titulo">Agenda de contatos</h1>
        <a href="novo.html" class="btn-novo">+ Novo contato</a>

        <!-- Tabela onde os contatos do Java serão renderizados de forma organizada -->
        <table class="tabela-contatos">
            <thead>
                <tr>
                    <th>Nome</th>
                    <th>Telefone</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<JavaBeans> lista = (ArrayList<JavaBeans>) request.getAttribute("contatos");
                    if (lista != null && !lista.isEmpty()) {
                        for (JavaBeans contato : lista) {
                %>
                            <tr>
                                <td><%= contato.getNome() %></td>
                                <td><%= contato.getFone() %></td>
                                <td>
                                    <a href="select?idcon=<%=contato.getIdcon() %>" class="btn-sm btn-primary">Editar</a>
                                    <a href="excluir?id=<%=contato.getIdcon() %>" class="btn-sm btn-danger">Excluir</a>
                                </td>
                            </tr>
                <%
                        }
                    } else {
                %>
                        <tr>
                            <!-- CORRIGIDO: Alterado o colspan de 2 para 3 para abranger toda a largura da tabela -->
                            <td colspan="3" style="text-align: center; color: #a0aec0; padding: 20px;">
                                Nenhum contato encontrado.
                            </td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var toast = document.getElementById('toastAtualizado');
            if (!toast) return;

            window.setTimeout(function () {
                toast.classList.remove('show');
                toast.classList.add('hide');
                window.setTimeout(function () {
                    toast.remove();
                }, 300);
            }, 3000);
        });
    </script>

</body>
</html>

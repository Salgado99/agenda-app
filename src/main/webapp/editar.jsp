<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>Editar Contato - Agenda</title>
    <link rel="icon" href="imagens/fone.png" type="image/x-icon">
    <style>
        /* --- Reset e Estilos Globais (Idênticos à sua agenda.jsp) --- */
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
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        /* --- Container Principal --- */
        .container {
            width: 100%;
            max-width: 500px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        /* --- Título do Formulário --- */
        .titulo {
            font-size: 1.8rem;
            color: #1a202c;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #edf2f7;
        }

        /* --- Grupos do Formulário --- */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #4a5568;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 0.95rem;
            color: #4a5568;
            background-color: #ffffff;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #3182ce;
            box-shadow: 0 0 0 3px rgba(49, 130, 206, 0.15);
        }

        /* --- Bloco de Botões --- */
        .btn-group {
            display: flex;
            gap: 12px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: background-color 0.2s ease, transform 0.1s ease;
        }

        .btn-save {
            background-color: #2b6cb0;
            color: #ffffff;
        }

        .btn-save:hover {
            background-color: #2c5282;
        }

        .btn-save:active {
            transform: scale(0.98);
        }

        .btn-cancel {
            background-color: #edf2f7;
            color: #4a5568;
            border: 1px solid #e2e8f0;
        }

        .btn-cancel:hover {
            background-color: #e2e8f0;
        }

        .btn-cancel:active {
            transform: scale(0.98);
        }
    </style>
</head>

<body>

    <div class="container">
        <h1 class="titulo">Editar contato</h1>

        <!-- O formulário envia os dados via POST para a rota de atualização mapeada no Controller -->
        <form action="update" method="post" name="frmContato">

            <!-- Campo de ID visível e protegido com 'readonly', puxando direto o atributo do request -->
            <div class="form-group">
                <label for="id">ID</label>
                <input type="text" id="id" name="idcon" class="form-control" 
                       value="<%= request.getAttribute("idcon") != null ? request.getAttribute("idcon") : "" %>" readonly>
            </div>

            <!-- Campo do Nome completo, mapeado para ler a chave "nome" do seu Controller -->
            <div class="form-group">
                <label for="nome">Nome completo</label>
                <input type="text" id="nome" name="nome" class="form-control"
                       value="<%= request.getAttribute("nome") != null ? request.getAttribute("nome") : "" %>" required>
            </div>

            <!-- Campo do Telefone, mapeado para ler a chave "fone" do seu Controller -->
            <div class="form-group">
                <label for="telefone">Telefone</label>
                <input type="text" id="telefone" name="telefone" class="form-control"
                       value="<%= request.getAttribute("fone") != null ? request.getAttribute("fone") : "" %>" required>
            </div>

            <!-- Campo do E-mail, mapeado para ler a chave "email" do seu Controller -->
            <div class="form-group">
                <label for="email">E-mail</label>
                <input type="email" id="email" name="email" class="form-control"
                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
            </div>

            <div class="btn-group">
                <a href="main" class="btn btn-cancel">Cancelar</a>
                <button type="submit" class="btn btn-save">Salvar Alterações</button>
            </div>
        </form>
    </div>

</body>

</html>

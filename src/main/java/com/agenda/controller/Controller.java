package com.agenda.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.agenda.model.DAO;
import com.agenda.model.JavaBeans;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/Controller", "/main", "/insert", "/select", "/update", "/excluir" })
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DAO dao = new DAO();

	public Controller() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getServletPath();

		if (action.equals("/main")) {
			contatos(request, response);
		} else if (action.equals("/insert")) {
			novoContato(request, response);
		} else if (action.equals("/select")) {
			listarContato(request, response);
		} else if (action.equals("/update")) {
			editarContato(request, response);
		} else if (action.equals("/excluir")) {
			deletarContato(request, response);
		} else {
			response.sendRedirect("index.html");
		}
	}

	protected void contatos(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<JavaBeans> lista = dao.listarContatos();

		request.setAttribute("contatos", lista);
		RequestDispatcher rd = request.getRequestDispatcher("agenda.jsp");
		rd.forward(request, response);
	}

	protected void novoContato(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		JavaBeans contato = new JavaBeans();

		contato.setNome(request.getParameter("nome"));
		contato.setFone(request.getParameter("telefone"));
		contato.setEmail(request.getParameter("email"));
		dao.inserirContato(contato);
		response.sendRedirect("main");
	}
	
	
	protected void listarContato(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		String idcon = request.getParameter("idcon");

		JavaBeans contato = new JavaBeans();
		contato.setIdcon(idcon);
		dao.selecionarContato(contato);

		request.setAttribute("idcon", contato.getIdcon());
		request.setAttribute("nome", contato.getNome());
		request.setAttribute("fone", contato.getFone());
		request.setAttribute("email", contato.getEmail());

		RequestDispatcher rd = request.getRequestDispatcher("editar.jsp");
		rd.forward(request, response);

	}

	protected void editarContato(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		JavaBeans contato = new JavaBeans();
		contato.setIdcon(request.getParameter("idcon"));
		contato.setNome(request.getParameter("nome"));
		contato.setFone(request.getParameter("telefone"));
		contato.setEmail(request.getParameter("email"));

		dao.alterarContato(contato);

		response.sendRedirect("main?updated=1");

	}

	protected void deletarContato(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		String idcon = request.getParameter("id");
		JavaBeans contato = new JavaBeans();
		contato.setIdcon(idcon);
		dao.excluirContato(contato);
		response.sendRedirect("main");

	}

	

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);



	}

}

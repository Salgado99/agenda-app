FROM tomcat:10.1-jdk17

# Remove a aplicação padrão do Tomcat para evitar conflitos
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia o arquivo gerado pelo Maven para a pasta de webapps do Tomcat
# O nome ROOT.war garante que a aplicação responda na raiz (/)
COPY target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

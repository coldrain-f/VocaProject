package edu.coldrain.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {

    private static final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String USER = "voca2";
    private static final String PASSWORD = "voca2";

    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void textConnection() {
        try {

            Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);

            //정상적으로 데이터베이스가 연결되면 연결된 Connection 객체가 출력된다.
            log.info(connection);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sipl.recursos;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author WM
 */
@WebService(serviceName = "MobilWebService")
public class MobilWebService {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "login")
    public String login(@WebParam(name = "user") String user, @WebParam(name = "passwd") String passwd) {
        String rs = "";
        if (user.equals("w1") && passwd.equals("w1")) {
            rs="OK";
        } else {
            rs="Fallo";
        }
        return rs;
    }
}
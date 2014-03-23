/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sipl.recursos;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;

/**
 * REST Web Service
 *
 * @author WM
 */
@Path("mobilwebserviceport")
public class MobilWebServicePort {
    private sipl.recursos_client.MobilWebService port;

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of MobilWebServicePort
     */
    public MobilWebServicePort() {
        port = getPort();
    }

    /**
     * Invokes the SOAP method finalizarPrestamo
     * @param codUsuario resource URI parameter
     * @param apiK resource URI parameter
     * @param apiS resource URI parameter
     * @return an instance of java.lang.String
     */
    @GET
    @Produces("text/plain")
    @Consumes("text/plain")
    @Path("finalizarprestamo/")
    public String getFinalizarPrestamo(@QueryParam("codUsuario") String codUsuario, @QueryParam("apiK") String apiK, @QueryParam("apiS") String apiS) {
        try {
            // Call Web Service Operation
            if (port != null) {
                java.lang.String result = port.finalizarPrestamo(codUsuario, apiK, apiS);
                return result;
            }
        } catch (Exception ex) {
            // TODO handle custom exceptions here
        }
        return null;
    }

    /**
     * Invokes the SOAP method login
     * @param user resource URI parameter
     * @param password resource URI parameter
     * @param apiK resource URI parameter
     * @return an instance of java.lang.String
     */
    @GET
    @Produces("text/plain")
    @Consumes("text/plain")
    @Path("login/")
    public String getLogin(@QueryParam("user") String user, @QueryParam("password") String password, @QueryParam("apiK") String apiK) {
        try {
            // Call Web Service Operation
            if (port != null) {
                java.lang.String result = port.login(user, password, apiK);
                return result;
            }
        } catch (Exception ex) {
            // TODO handle custom exceptions here
        }
        return null;
    }

    /**
     * Invokes the SOAP method addPrestamo
     * @param codMateriales resource URI parameter
     * @param codUsuario resource URI parameter
     * @param apiK resource URI parameter
     * @param apiS resource URI parameter
     * @return an instance of java.lang.String
     */
    @GET
    @Produces("text/plain")
    @Consumes("text/plain")
    @Path("addprestamo/")
    public String getAddPrestamo(@QueryParam("codMateriales") String codMateriales, @QueryParam("codUsuario") String codUsuario, @QueryParam("apiK") String apiK, @QueryParam("apiS") String apiS) {
        try {
            // Call Web Service Operation
            if (port != null) {
                java.lang.String result = port.addPrestamo(codMateriales, codUsuario, apiK, apiS);
                return result;
            }
        } catch (Exception ex) {
            // TODO handle custom exceptions here
        }
        return null;
    }

    /**
     *
     */
    private sipl.recursos_client.MobilWebService getPort() {
        try {
            
            // Call Web Service Operation
            sipl.recursos_client.MobilWebService_Service service = new sipl.recursos_client.MobilWebService_Service();
            sipl.recursos_client.MobilWebService p = service.getMobilWebServicePort();
            return p;
        } catch (Exception ex) {
            // TODO handle custom exceptions here
        }
        return null;
    }
}

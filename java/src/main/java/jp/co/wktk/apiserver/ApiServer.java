// vim: set expandtab ts=2 sw=2 nowrap ft=java ff=unix :
package jp.co.wktk.apiserver;

import java.util.Set;
import java.util.Map;
import java.util.HashSet;
import javax.ws.rs.core.Application;
import com.googlecode.htmleasy.HtmleasyProviders;
import jp.co.wktk.apiserver.ApiHandler;

import java.io.File;
import java.io.InputStream;
import java.io.FileInputStream;
import org.yaml.snakeyaml.Yaml;

public class ApiServer extends Application {
  public ApiServer() {
    super();
    try {
      InputStream i = new FileInputStream(new File("../config.yaml"));
      Yaml yaml = new Yaml();
      Map config = (Map)yaml.load(i);
      System.out.println(config);
    } catch (java.io.FileNotFoundException e) {
    }
  }

  public Set<Class<?>> getClasses() {
    Set<Class<?>> myServices = new HashSet<Class<?>>();

    // API based on JAX-RS
    myServices.add(ApiHandler.class);

    // htmleasy
    myServices.addAll(HtmleasyProviders.getClasses());

    return myServices;
  }
}

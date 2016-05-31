package com.ppe4.starsup;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class LoginActivity extends AppCompatActivity {
    private EditText ETnomUtilisateur, ETMDP;
    private Button Bconnexion;
    private static final String URL = "https://starsup.herokuapp.com/login.php";
    private RequestQueue fileRequete;
    private StringRequest requete;
    private JSONObject JO;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        ETnomUtilisateur = (EditText) findViewById(R.id.ETnomUtilisateur);
        ETMDP = (EditText) findViewById(R.id.ETMDP);
        Bconnexion = (Button) findViewById(R.id.Bconnexion);

        final MonApplication mApp = ((MonApplication)getApplicationContext());

        fileRequete = Volley.newRequestQueue(this);

        Bconnexion.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                requete = new StringRequest(Request.Method.POST, URL, new Response.Listener<String>() {
                    @Override
                    public void onResponse(String reponse) {
                        try {
                            JO = new JSONObject(reponse);

                            if (JO.names().get(0).equals("succes")) {
                                mApp.setId_session(JO.getString("id_inspecteur"));
                                Toast.makeText(getApplicationContext(), JO.getString("succes"), Toast.LENGTH_SHORT).show();
                                startActivity(new Intent(getApplicationContext(), ListeActivity.class));
                                ETnomUtilisateur.setText("");
                                ETMDP.setText("");
                            } else {
                                Toast.makeText(getApplicationContext(), JO.getString("erreur"), Toast.LENGTH_SHORT).show();
                            }
                        } catch (JSONException exception) {
                            exception.printStackTrace();
                        }
                    }
                }, new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                    }
                }) {
                    @Override
                    protected Map<String, String> getParams() throws AuthFailureError {
                        HashMap<String, String> dictionnaire = new HashMap<>();
                        dictionnaire.put("nomUtilisateur", ETnomUtilisateur.getText().toString());
                        dictionnaire.put("MDP", ETMDP.getText().toString());

                        return dictionnaire;
                    }
                };
                fileRequete.add(requete);
            }
        });
    }
}

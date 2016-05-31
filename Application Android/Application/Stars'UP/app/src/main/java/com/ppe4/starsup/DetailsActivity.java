package com.ppe4.starsup;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.RatingBar;
import android.widget.TextView;
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

public class DetailsActivity extends AppCompatActivity {
    private TextView TVnom;
    private RatingBar RBnote;
    private EditText ETcommentaire;
    private CheckBox CBcontrevisite;
    private Button Bvalider;
    private static final String URL = "https://starsup.herokuapp.com/details.php";
    private RequestQueue fileRequete;
    private StringRequest requete;
    private JSONObject JO;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_details);

        TVnom = (TextView) findViewById(R.id.TVnom);
        RBnote = (RatingBar) findViewById(R.id.RBnote);
        ETcommentaire = (EditText) findViewById(R.id.ETcommentaire);
        CBcontrevisite = (CheckBox) findViewById(R.id.CBcontrevisite);
        Bvalider = (Button) findViewById(R.id.Bvalider);

        fileRequete = Volley.newRequestQueue(this);

        final MonApplication mApp = ((MonApplication)getApplicationContext());

        Intent I = getIntent();
        Bundle bundle = I.getExtras();

        TVnom.setText((String)bundle.get("test1"));

        Bvalider.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                requete = new StringRequest(Request.Method.POST, URL, new Response.Listener<String>() {
                    @Override
                    public void onResponse(String reponse) {
                        try {
                            JO = new JSONObject(reponse);

                            if (JO.names().get(0).equals("succes")) {
                                Toast.makeText(getApplicationContext(), JO.getString("succes"), Toast.LENGTH_SHORT).show();
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
                        dictionnaire.put("numVisite", mApp.getId_visite());
                        dictionnaire.put("noteVisite", String.valueOf(RBnote.getRating()));
                        dictionnaire.put("commentaireVisite", ETcommentaire.getText().toString());
                        if(CBcontrevisite.isChecked()){
                            dictionnaire.put("contreVisite", "1");
                        } else {
                            dictionnaire.put("contreVisite", "0");
                        }
                        return dictionnaire;
                    }
                };
                fileRequete.add(requete);
            }
        });
    }
}

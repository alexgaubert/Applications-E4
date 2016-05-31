package com.ppe4.starsup;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class ListeActivity extends AppCompatActivity {
    private List<Visite> Lvisites = new ArrayList<>();
    private ProgressDialog PD;
    private VisiteAdapter adapteur;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_liste);

        String URL = "https://starsup.herokuapp.com/liste.php";
        final ListView LVvisites = (ListView) findViewById(R.id.LVvisites);

        adapteur = new VisiteAdapter(this, Lvisites);
        assert LVvisites != null;
        LVvisites.setAdapter(adapteur);

        final MonApplication mApp = ((MonApplication)getApplicationContext());

        PD = new ProgressDialog(this);
        PD.setMessage("Chargement des visites en cours...");
        PD.show();

        LVvisites.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent I = new Intent(ListeActivity.this , DetailsActivity.class);
                I.putExtra("id_visite", Lvisites.get(position).getNum());
                I.putExtra("test1", Lvisites.get(position).getNom());
                mApp.setId_visite(Lvisites.get(position).getNum());
                startActivity(I);
            }
        });

        JsonArrayRequest JARvisites = new JsonArrayRequest(URL, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray reponse) {
                hidePDialog();
                JSONObject JO;
                for(int i = 0; i < reponse.length(); i++) {
                    try {
                        JO = reponse.getJSONObject(i);
                        Log.d("test", mApp.getId_session());

                        if(Objects.equals(JO.getString("id_inspecteur"), mApp.getId_session())){
                            Visite V = new Visite();
                            V.setNum(JO.getString("id_visite"));
                            V.setNom(JO.getString("nom"));
                            Lvisites.add(V);
                        }
                    } catch (JSONException JE) {
                        JE.printStackTrace();
                    }
                }
                adapteur.notifyDataSetChanged();
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError VE) {
                hidePDialog();
            }
        });

        MonApplication.getInstance().addToRequestQueue(JARvisites);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        hidePDialog();
    }

    private void hidePDialog() {
        if (PD != null) {
            PD.dismiss();
            PD = null;
        }
    }
}

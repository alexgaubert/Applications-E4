package com.ppe4.starsup;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.NetworkImageView;

import java.util.List;

/**
 * Created by Alex on 27/04/2016.
 */
public class VisiteAdapter extends BaseAdapter {
    private Activity activity;
    private LayoutInflater inflater;
    private List<Visite> visitesItems;

    public VisiteAdapter(Activity activity, List<Visite> visitesItems) {
        this.activity = activity;
        this.visitesItems = visitesItems;
    }

    @Override
    public int getCount() {
        return visitesItems.size();
    }

    @Override
    public Object getItem(int location) {
        return visitesItems.get(location);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        if (inflater == null) {
            inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        }
        if (convertView == null) {
            convertView = inflater.inflate(R.layout.row_visite, null);
        }

        TextView TVnom = (TextView) convertView.findViewById(R.id.TVnom);

// getting billionaires data for the row
        Visite visite = visitesItems.get(position);

// name
        TVnom.setText(visite.getNom());

// note

        return convertView;
    }
}

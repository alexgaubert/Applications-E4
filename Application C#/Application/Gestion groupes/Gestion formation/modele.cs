using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Data;
using System.Windows.Forms;
using System.Collections;

namespace Gestion_groupe
{
    class modele
    {
        private MySqlConnection myConnection;
        private MySqlDataAdapter mySqlDataAdapter = new MySqlDataAdapter();
        private DataSet dataSet = new DataSet();
        private DataView dv_groupe = new DataView(), dv_artistes = new DataView();
        private ArrayList rapport = new ArrayList();
        
        
        private bool connopen = false;
        private bool errgrave = false;
        private bool chargement = false;
        private bool errmaj = false;
        private char vaction, vtable;        

        public modele()
        {

        }

        #region Accesseurs
        public bool Connopen
        {
            get { return connopen; }
            set { connopen = value; }
        }

        public bool Errgrave
        {
            get { return errgrave; }
            set { errgrave = value; }
        }

        public bool Chargement
        {
            get { return chargement; }
            set { chargement = value; }
        }

        public DataView Dv_artistes
        {
            get { return dv_artistes; }
            set { dv_artistes = value; }
        }

        public DataView Dv_groupes
        {
            get { return dv_groupe; }
            set { dv_groupe = value; }
        }

        public bool Errmaj
        {
            get { return errmaj; }
            set { errmaj = value; }
        }

        public char Vtable
        {
            get { return vtable; }
            set { vtable = value; }
        }

        public char Vaction
        {
            get { return vaction; }
            set { vaction = value; }
        }

        public ArrayList Rapport
        {
            get { return rapport; }
            set { rapport = value; }
        }
        #endregion

        public void seconnecter()
        {
            String myConnectionString = "Database=bd_angerson;Data Source=localhost;User Id=root;";//192.168.219.4 / alex pour la ferme
            myConnection = new MySqlConnection(myConnectionString);

            try
            {
                myConnection.Open();
                connopen = true;
            }
            catch (Exception err)
            {
                MessageBox.Show("Erreur : " + err, "Problème de connexion à la base de données", MessageBoxButtons.OK, MessageBoxIcon.Error);
                connopen = false;
                errgrave = true;
            }
        }

        public void sedeconnecter()
        {
            if (!connopen)
            {
                return;
            }

            try
            {
                myConnection.Close();
                myConnection.Dispose();
                connopen = false;
            }
            catch (Exception err)
            {
                MessageBox.Show("Erreur : " + err, "Problème de déconnexion à la base de données", MessageBoxButtons.OK, MessageBoxIcon.Error);
                errgrave = true;
            }
        }

        public void import()
        {
            if (!connopen) return;
            mySqlDataAdapter.SelectCommand = new MySqlCommand("SELECT * FROM groupe; SELECT * FROM membre;", myConnection);
            try
            {
                dataSet.Clear();
                mySqlDataAdapter.Fill(dataSet);
                MySqlCommand vcommand = myConnection.CreateCommand();

                vcommand.CommandText = "SELECT AUTO_INCREMENT AS last_id FROM INFORMATION_SCHEMA.TABLES WHERE table_name = 'membre'";
                UInt64 der_membre = (UInt64)vcommand.ExecuteScalar();
                dataSet.Tables[1].Columns[0].AutoIncrement = true;
                dataSet.Tables[1].Columns[0].AutoIncrementSeed = Convert.ToInt64(der_membre);
                dataSet.Tables[1].Columns[0].AutoIncrementStep = 1;

                dv_groupe = dataSet.Tables[0].DefaultView;
                dv_artistes = dataSet.Tables[1].DefaultView;

                chargement = true;
            }
            catch (Exception err)
            {
                MessageBox.Show("Erreur : " + err, "Problème de chargement du dataset", MessageBoxButtons.OK, MessageBoxIcon.Error);
                errgrave = true;
            }
        }

        public void export()
        {
            if (!connopen) return;
            try
            {
                add_membre();
                maj_membre();
                del_membre();
            }
            catch (Exception err)
            {
                MessageBox.Show("Erreur : " + err, "Problème d'export du dataset", MessageBoxButtons.OK, MessageBoxIcon.Error);
                errgrave = true;
            }
        }

        private void OnRowUpdated(object sender, MySqlRowUpdatedEventArgs args)
        {
            string msg="";
            Int64 nb = 0;
            if (args.Status == UpdateStatus.ErrorsOccurred)
            {
                if (vaction == 'd' || vaction == 'u')
                {
                    MySqlCommand vcommand = myConnection.CreateCommand();
                    if (vtable == 'p')
                    {
                        vcommand.CommandText = "SELECT COUNT(*) FROM membre WHERE idMembre = '" +args.Row[0, DataRowVersion.Original] + "'";
                    }
                    nb = (Int64)vcommand.ExecuteScalar();
                }
                if (vaction == 'd')
                {
                    if (nb == 1)
                    {
                        if (vtable == 'p')
                        {
                            msg = "Le membre " + args.Row[0, DataRowVersion.Original] + " ne peut pas être supprimé car il a été modifié dans la base de données";
                        }
                        rapport.Add(msg);
                        errmaj = true;
                    }
                }
                if (vaction == 'u')
                {
                    if (nb == 1)
                    {
                        if (vtable == 'p')
                        {
                            msg = "Le membre " + args.Row[0, DataRowVersion.Original] + " ne peut pas être mis à jour car il a été supprimé dans la base de données";
                        }
                        rapport.Add(msg);
                        errmaj = true;
                    }
                    else
                    {
                        if (vtable == 'p')
                        {
                            msg = "Le membre " + args.Row[0, DataRowVersion.Original] + " ne peut pas être mis à jour car il a été supprimé dans la base de données";
                        }
                        rapport.Add(msg);
                        errmaj = true;
                    }
                }
                if (vaction == 'c')
                {
                    if (vtable == 'p')
                    {
                        msg = "Le membre " + args.Row[0, DataRowVersion.Current] + " ne peut pas être créé car il y a un conflit de données avec la base de données";
                    }
                    rapport.Add(msg);
                    errmaj = true;
                }
            }
        }

        public void add_membre()
        {
            vaction = 'c';
            vtable = 'p';
            if (!connopen) return;
            mySqlDataAdapter.RowUpdated += new MySqlRowUpdatedEventHandler(OnRowUpdated);
            mySqlDataAdapter.InsertCommand = new MySqlCommand("insert into membre (prenom,nom,idGroupe) values(?prenom,?nom,?idGroupe)", myConnection);
            mySqlDataAdapter.InsertCommand.Parameters.Add("?nom", MySqlDbType.Text, 65535, "nom");
            mySqlDataAdapter.InsertCommand.Parameters.Add("?prenom", MySqlDbType.Text, 65535, "prenom");
            mySqlDataAdapter.InsertCommand.Parameters.Add("?idGroupe", MySqlDbType.Int16, 10, "idGroupe");
            mySqlDataAdapter.ContinueUpdateOnError = true;
            DataTable table = dataSet.Tables[1];
            mySqlDataAdapter.Update(table.Select(null, null, DataViewRowState.Added));
            mySqlDataAdapter.RowUpdated -= new MySqlRowUpdatedEventHandler(OnRowUpdated);
        }

        public void maj_membre()
        {
            vaction = 'u';
            vtable = 'p';
            if (!connopen) return;
            mySqlDataAdapter.RowUpdated += new MySqlRowUpdatedEventHandler(OnRowUpdated);
            mySqlDataAdapter.UpdateCommand = new MySqlCommand("update membre set nom=?nom,prenom=?prenom, idGroupe=?idGroupe where idMembre = ?num ", myConnection);
            mySqlDataAdapter.ContinueUpdateOnError = true;
            DataTable table = dataSet.Tables[1];
            mySqlDataAdapter.Update(table.Select(null, null, DataViewRowState.Added));
            mySqlDataAdapter.RowUpdated -= new MySqlRowUpdatedEventHandler(OnRowUpdated);
        }

        public void del_membre()
        {
            vaction = 'd';
            vtable = 'p';
            if (!connopen) return;
            mySqlDataAdapter.RowUpdated += new MySqlRowUpdatedEventHandler(OnRowUpdated);
            mySqlDataAdapter.DeleteCommand = new MySqlCommand("delete from membre where idMembre = ?num;", myConnection);
            mySqlDataAdapter.ContinueUpdateOnError = true;
            DataTable table = dataSet.Tables[1];
            mySqlDataAdapter.Update(table.Select(null, null, DataViewRowState.Added));
            mySqlDataAdapter.RowUpdated -= new MySqlRowUpdatedEventHandler(OnRowUpdated);
        }
    }
}

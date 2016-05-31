using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Gestion_groupe
{
    public static class controleur
    {
        static modele vmodele;

        public static void init(){
            vmodele = new modele();
        }

        internal static modele Vmodele
        {
            get { return controleur.vmodele; }
            set { controleur.vmodele = value; }
        }

        public static void crud_artistes(Char c, String cle)
        {
            int index = 0;
            formCRUD formCRUD = new formCRUD();
            if (c== 'c')
            {
                formCRUD.TextBox1.Text = "";
                formCRUD.TextBox2.Text = "";
                formCRUD.TextBox3.Text = "";
            }
            if (c=='u' || c=='d')
            {
                string sortExpression = "idMembre";
                vmodele.Dv_artistes.Sort = sortExpression;
                index = vmodele.Dv_artistes.Find(cle);
                formCRUD.TextBox1.Text = vmodele.Dv_artistes[index][1].ToString();
                formCRUD.TextBox2.Text = vmodele.Dv_artistes[index][2].ToString();
                formCRUD.TextBox3.Text = vmodele.Dv_artistes[index][3].ToString();
            }
            formCRUD.ShowDialog();
            if (formCRUD.DialogResult == System.Windows.Forms.DialogResult.OK)
            {
                if (c=='c')
                {
                    DataRowView newRow = vmodele.Dv_artistes.AddNew();
                    newRow["idMembre"] = 15;
                    newRow["nom"] = formCRUD.TextBox1.Text;
                    newRow["prenom"] = formCRUD.TextBox2.Text;
                    newRow["idGroupe"] = formCRUD.TextBox3.Text;
                    newRow.EndEdit();
                }
                if (c=='u')
                {
                    vmodele.Dv_artistes[index]["nom"] = formCRUD.TextBox1.Text;
                    vmodele.Dv_artistes[index]["prenom"] = formCRUD.TextBox2.Text;
                    vmodele.Dv_artistes[index]["idGroupe"] = formCRUD.TextBox3.Text;
                }
                if (c == 'd')
                {
                    vmodele.Dv_artistes.Table.Rows[index].Delete();
                }
                MessageBox.Show("Les données ont bien été enregistrées");
                formCRUD.Dispose();
            }
            else
            {
                MessageBox.Show("Les données n'ont pas été enregistrées");
                formCRUD.Dispose();
            }
        }
    }
}

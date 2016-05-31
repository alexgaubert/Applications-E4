using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Gestion_groupe
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_FormClosed(object sender, FormClosedEventArgs e)
        {
            controleur.Vmodele.sedeconnecter();
        }

        private void importToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            controleur.init();
            controleur.Vmodele.seconnecter();
            if (controleur.Vmodele.Connopen == false)
            {
                MessageBox.Show("Erreur");
            }
            else
            {
                controleur.Vmodele.import();
                if (controleur.Vmodele.Chargement == true)
                {
                    gestionDesDonnéesToolStripMenuItem.Enabled = true;
                }
            }
        }

        private void gestionDesDonnéesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormMembre FP = new FormMembre();
            FP.MdiParent = this;
            FP.Show();
        }

        private void exportToolStripMenuItem_Click(object sender, EventArgs e)
        {
            controleur.Vmodele.seconnecter();
            if (controleur.Vmodele.Connopen == false)
            {
                MessageBox.Show("Erreur");
            }
            else
            {
                controleur.Vmodele.export();
            }
            controleur.Vmodele.sedeconnecter();
        }
    }
}

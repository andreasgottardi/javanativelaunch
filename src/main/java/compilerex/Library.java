/*
 * This Java source file was generated by the Gradle 'init' task.
 */
package compilerex;

import java.awt.Dimension;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.WindowConstants;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Library {

	private static final Logger logger = LoggerFactory.getLogger(Library.class);

	public static void main(String[] args) {
		logger.info("Info message.");
		logger.debug("Debug message.");
		logger.debug("Application started.");
		JFrame jframe = new JFrame("A simple gui example.");
		jframe.setIconImage(new ImageIcon(Library.class.getResource("/icon.png")).getImage());
		jframe.getContentPane().setPreferredSize(new Dimension(1280, 720));
		jframe.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
		jframe.pack();
		jframe.setVisible(true);
		logger.debug("Main thread done.");
	}

	public boolean someLibraryMethod() {
		return true;
	}
}

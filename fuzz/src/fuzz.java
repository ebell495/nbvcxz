import java.nio.file.Paths;
import java.nio.file.Files;
import java.nio.file.Path;
import me.gosimple.nbvcxz.Nbvcxz;
import me.gosimple.nbvcxz.scoring.Result;

public class fuzz {
    // public static void main(String[] args) throws Exception
    // {
    //     Path path = Paths.get(args[0]);
    //     byte[] data = Files.readAllBytes(path);
    //     if(data.length == 0) {
    //         return;
    //     }

    //     Nbvcxz nbvcxz = new Nbvcxz();
    //     Result result = nbvcxz.estimate(new String(data));
    // }

    public static void fuzzerTestOneInput(byte[] data) {
        Nbvcxz nbvcxz = new Nbvcxz();
        Result result = nbvcxz.estimate(new String(data));
    }
}

package co.itfusion.interfaces;

public interface ISetup {

    default void setDependencies() {}
    default void setClickEvents() {}
    default void setInputEvents() {}

}
